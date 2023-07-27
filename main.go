package main

import (
	"confluence-gardner/conf"
	"fmt"
	"log"
	"math/rand"
	"net/url"
	"time"

	"github.com/spf13/viper"
	goconfluence "github.com/virtomize/confluence-go-api"
)

func getDomainName(confluence_url string) string {
	url, err := url.Parse(confluence_url)
	if err != nil {
		log.Fatal(err)
	}

	return url.Scheme + "://" + url.Host

}

func main() {

	conf.ReadConf()
	conf.ParseCliOpts()

	// initialize a new api instance

	c_url := viper.GetString("confluence_url")
	c_token := viper.GetString("confluence_token")
	c_page_id := viper.GetString("confluence_page_id")

	domain := getDomainName(c_url)

	api, err := goconfluence.NewAPI(c_url, "", c_token)
	if err != nil {
		log.Fatal(err)
	}

	childPages, err := api.GetChildPages(c_page_id)
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
		fmt.Printf("Confluence page [%s](%s/pages/viewpage.action?pageId=%s) was last updated at %s. Please check its contents.", oldArticles[randIdx].Title, domain, oldArticles[randIdx].ID, oldArticles[randIdx].lastUpdateTime.Format("2006-01-02"))
	} else {
		fmt.Printf("There are no old Confluence Pages. Congratulations!")
	}
}