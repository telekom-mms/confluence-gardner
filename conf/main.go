package conf

import (
	"fmt"
	"log"
	"os"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

var version string

func ReadConf() {
	viper.SetConfigName("application") // name of config file (without extension)
	viper.AddConfigPath(".")           // optionally look for config in the working directory
	viper.SetConfigType("yaml")        // REQUIRED if the config file does not have the extension in the name

	viper.AutomaticEnv()
}

func ParseCliOpts() {

	var versionFlag bool
	pflag.BoolVar(&versionFlag, "version", false, "Print the version of the program")

	pflag.StringP("confluence_url", "u", "https://confluence.example.com/rest/api", "The URL to the Confluence REST-API with http(s)")
	pflag.StringP("confluence_token", "t", "", "The token to authenticate against the Confluence REST-API")
	pflag.StringP("confluence_page_id", "i", "", "The ID for which to crawl child pages")


	pflag.Parse()
	err := viper.BindPFlags(pflag.CommandLine)
	if err != nil {
		log.Fatal(err)
	}
	if versionFlag {
		fmt.Println(version)
		os.Exit(0)
	}

	if viper.GetString("confluence_url") == "" {
		fmt.Println("Please add a confluence url")
		pflag.PrintDefaults()
		os.Exit(1)
	}

	if viper.GetString("confluence_page_id") == "" {
		fmt.Println("Please add a page id to crawl")
		pflag.PrintDefaults()
		os.Exit(1)
	}

	if viper.GetString("confluence_token") == "" {
		fmt.Println("Please add a token")
		pflag.PrintDefaults()
		os.Exit(1)
	}
}
