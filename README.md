# Confluence Gardner

Confluence-Gardner is a simple tool designed to help maintain up-to-date Confluence pages. The software checks the age of Confluence pages and returns the URL of the pages older than 90 days, indicating a potential need for review and update.

# Getting Started

Follow these instructions to get the Confluence-Gardner up and running on your local machine.


## Prerequisites

    Golang 1.16 or later
    Confluence API access

## Installation

### Download the binary

Just download the binary from the releases-page and execute it.

### Use the provided Container

You can use the provider container:

     docker run ghcr.io/telekom-mms/confluence-gardner

### Manually

Clone the Confluence-Gardner repository:

    git clone https://github.com/telekom-mms/confluence-gardner.git
    cd confluence-gardner

Install the required Go packages using go mod:

    go mod download

Build the tool:

    go build

## Usage

    confluence-gardner --help
      -i, --confluence_page_id string   The ID for which to crawl child pages
      -t, --confluence_token string     The token to authenticate against the Confluence REST-API
      -u, --confluence_url string       The URL to the Confluence REST-API with http(s) (default "https://confluence.example.com/rest/api")

## Contributing

Contributions to Confluence-Gardner are welcome! Please follow these steps:

    Fork the repository on GitHub.
    Make your changes in a new branch.
    Create a pull request with a clear description of your changes.
    We will review and merge your contribution if applicable.

## License

This project is licensed under the GPLv3 - see the LICENSE file for details.

