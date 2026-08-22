ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:20dc7edae3f7efe09b934aca4b347b00bb4ae0f2864b6131771687ae6d54891f

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
