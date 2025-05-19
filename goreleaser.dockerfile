ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:cef75d12148305c54ef5769e6511a5ac3c820f39bf5c8a4fbfd5b76b4b8da843

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
