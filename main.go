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

type Article struct {
	ID             string
	Title          string
	LastUpdateTime time.Time
}

func getDomainName(confluenceURL string) string {
	parsedURL, err := url.Parse(confluenceURL)
	if err != nil {
		log.Fatal(err)
	}

	return parsedURL.Scheme + "://" + parsedURL.Host
}

func getOldArticles(api *goconfluence.API, pageID string, now time.Time, maxDepth int, ageThresholdHours float64) ([]Article, error) {
	var oldArticles []Article
	err := getOldArticlesRecursive(api, pageID, now, maxDepth, 0, ageThresholdHours, &oldArticles)
	return oldArticles, err
}

func getOldArticlesRecursive(api *goconfluence.API, pageID string, now time.Time, maxDepth, currentDepth int, ageThresholdHours float64, oldArticles *[]Article) error {
	if currentDepth > maxDepth {
		return nil
	}

	childPages, err := api.GetChildPages(pageID)
	if err != nil {
		return fmt.Errorf("error getting child pages: %w", err)
	}

	for _, page := range childPages.Results {
		history, err := api.GetHistory(page.ID)
		if err != nil {
			return fmt.Errorf("failed to fetch history for page %s: %w", page.ID, err)
		}

		lastUpdateTime, err := time.Parse("2006-01-02T15:04:05.000Z", history.LastUpdated.When)
		if err != nil {
			return fmt.Errorf("error parsing last update time: %w", err)
		}

		if now.Sub(lastUpdateTime).Hours() > ageThresholdHours {
			*oldArticles = append(*oldArticles, Article{ID: page.ID, Title: page.Title, LastUpdateTime: lastUpdateTime})
		}

		// use Recursion to dive into each Layer of Confluence pages
		err = getOldArticlesRecursive(api, page.ID, now, maxDepth, currentDepth+1, ageThresholdHours, oldArticles)
		if err != nil {
			return err
		}
	}

	return nil
}

func main() {
	conf.ReadConf()
	conf.ParseCliOpts()

	cURL := viper.GetString("confluence_url")
	cToken := viper.GetString("confluence_token")
	cPageID := viper.GetString("confluence_page_id")
	maxDepth := viper.GetInt("max_depth")
	ageThresholdHours := viper.GetFloat64("age_threshold_hours")

	domain := getDomainName(cURL)

	goconfluence.SetDebug(viper.GetViper().GetBool("debug"))

	api, err := goconfluence.NewAPI(cURL, "", cToken)
	if err != nil {
		log.Fatal("Error connecting to Confluence: ", err)
	}

	now := time.Now()
	oldArticles, err := getOldArticles(api, cPageID, now, maxDepth, ageThresholdHours)
	if err != nil {
		log.Fatal(err)
	}

	if len(oldArticles) > 0 {
		r := rand.New((rand.NewSource(time.Now().UnixNano())))
		randIdx := r.Intn(len(oldArticles))
		selectedArticle := oldArticles[randIdx]
		fmt.Printf("Confluence page [%s](%s/pages/viewpage.action?pageId=%s) was last updated at %s. Please check its contents.\n", selectedArticle.Title, domain, selectedArticle.ID, selectedArticle.LastUpdateTime.Format("2006-01-02"))
	} else {
		fmt.Println("There are no old Confluence Pages. Congratulations!")
	}
}
