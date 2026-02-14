ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:9fc4940908fb9f2dadfccba39b28a69043c75db3cef810c5653eac319121fcc3

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
