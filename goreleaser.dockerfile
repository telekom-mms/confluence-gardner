ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:9e9b50d2048db3741f86a48d939b4e4cc775f5889b3496439343301ff54cdba8

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
