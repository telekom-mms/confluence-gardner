ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:27769871031f67460f1545a52dfacead6d18a9f197db77110cfc649ca2a91f44

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
