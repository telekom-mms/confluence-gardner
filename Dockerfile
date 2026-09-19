# syntax=docker/dockerfile:1@sha256:ecfaec9ed6d810b56388c508f4121597bfbba70d41a6dfeee4d8cad5f295fc32
FROM golang:1.27-alpine@sha256:4cb7ac979db5fcc41cae44b2227ba5ab8a51e8807f40d9ba4dee20a0ad960b5b AS build-env
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
FROM alpine:latest@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6
COPY --from=build-env /go/src/confluence-gardner/confluence-gardner  /usr/local/bin/confluence-gardner
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["confluence-gardner"]
