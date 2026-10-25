# syntax=docker/dockerfile:1@sha256:4edf897a3ffa55b89f906fc8cc78afdb3f1834cc9c7083565e611a8a7d5fe99e
FROM golang:1.27-alpine@sha256:f2c872bcee949b7be9c490efd02b48a8a2fbf947cdf533f1c58525ec9d8170fd AS build-env
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
FROM alpine:latest@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a
COPY --from=build-env /go/src/confluence-gardner/confluence-gardner  /usr/local/bin/confluence-gardner
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["confluence-gardner"]
