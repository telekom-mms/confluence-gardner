ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:d8d01e2d5868f622544543ca0311679bbc2f3fbf7f7bafd11af78a284c479ea3

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
