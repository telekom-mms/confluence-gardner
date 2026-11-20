# syntax=docker/dockerfile:1@sha256:572cebbc2b15e6f84c077742952674889cb63cd5e9b80abdffcbe587b6f19183
FROM golang:1.27-alpine@sha256:70bd7ddea8b6cbe5d6943cde279d6b67feb10cc924fb9100d1d8757c1575b280 AS build-env
RUN mkdir -p /go/src/confluence-gardner

# Copy the module files first and then download the dependencies. If this
# doesn't change, we won't need to do this again in future builds.
WORKDIR /go/src/confluence-gardner

COPY go.* ./
RUN go mod download

WORKDIR /go/src/confluence-gardner
ADD conf conf
COPY *.go ./
RUN go build -o confluence-gardner

# final stage
FROM alpine:latest@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf
COPY --from=build-env /go/src/confluence-gardner/confluence-gardner  /usr/local/bin/confluence-gardner
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["confluence-gardner"]
