ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:7a4bffcb07307d97aa731b50cb6ab22a68a8314426f4e4428335939b5b1943a5

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
