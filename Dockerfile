# syntax=docker/dockerfile:1@sha256:fe40cf4e92cd0c467be2cfc30657a680ae2398318afd50b0c80585784c604f28
FROM golang:1.22-alpine@sha256:1a478681b671001b7f029f94b5016aed984a23ad99c707f6a0ab6563860ae2f3 AS build-env
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
FROM alpine:latest@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5
COPY --from=build-env /go/src/confluence-gardner/confluence-gardner  /usr/local/bin/confluence-gardner
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["confluence-gardner"]
