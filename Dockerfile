# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5
FROM golang:1.23-alpine@sha256:9a31ef0803e6afdf564edc8ba4b4e17caed22a0b1ecd2c55e3c8fdd8d8f68f98 AS build-env
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
FROM alpine:latest@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a
COPY --from=build-env /go/src/confluence-gardner/confluence-gardner  /usr/local/bin/confluence-gardner
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["confluence-gardner"]
