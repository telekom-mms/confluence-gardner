package main

import (
	"fmt"
	"log"
	"math/rand"
	"net/url"
	"time"

	"confluence-gardner/conf"

	"github.com/spf13/viper"
	goconfluence "github.com/virtomize/confluence-go-api"
)

func getDomainName(confluenceURL string) string {
	url, err := url.Parse(confluenceURL)
	if err != nil {
		log.Fatal(err)
	}

	return url.Scheme + "://" + url.Host
}

func main() {
	conf.ReadConf()
	conf.ParseCliOpts()

	// initialize a new api instance

	cURL := viper.GetString("confluence_url")
	cToken := viper.GetString("confluence_token")
	cPageID := viper.GetString("confluence_page_id")

	domain := getDomainName(cURL)

	api, err := goconfluence.NewAPI(cURL, "", cToken)
	if err != nil {
		log.Fatal(err)
	}

	childPages, err := api.GetChildPages(cPageID)
	if err != nil {
		log.Fatal(err)
	}

	now := time.Now()

	type Articles struct {
		ID             string
		Title          string
		lastUpdateTime time.Time
	}

	var oldArticles []Articles

	for _, v := range childPages.Results {
		hist, err := api.GetHistory(v.ID)
		if err != nil {
			log.Fatal(err)
		}
		lastUpdateTimeString := hist.LastUpdated.When
		lastUpdateTime, err := time.Parse("2006-01-02T15:04:05.000Z", lastUpdateTimeString)
		if err != nil {
			fmt.Println(err)
		}

		difference := now.Sub(lastUpdateTime)

		// 3000h ~ 3 months
		if difference.Hours() > 3000 {
			oldArticles = append(oldArticles, Articles{ID: v.ID, Title: v.Title, lastUpdateTime: lastUpdateTime})
		}

	}

	if len(oldArticles) > 0 {
		// get random article
		rand.Seed(time.Now().UnixNano())
		randIdx := rand.Intn(len(oldArticles))
		fmt.Printf("Confluence page [%s](%s/pages/viewpage.action?pageId=%s) was last updated at %s. Please check its contents.\n", oldArticles[randIdx].Title, domain, oldArticles[randIdx].ID, oldArticles[randIdx].lastUpdateTime.Format("2006-01-02"))
	} else {
		fmt.Println("There are no old Confluence Pages. Congratulations!")
	}
}
