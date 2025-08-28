ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:d605e138bb398428779e5ab490a6bbeeabfd2551bd919578b1044718e5c30798

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
