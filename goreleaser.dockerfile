ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:57c1e4c72feb5925c4763ae4f6bd2013ad3854f57eff5b60dd9acb1ce0abc66e

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
