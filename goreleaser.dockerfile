ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:ca90dc2333005edbc15bccbd7cd61c08ee0fd9dd1fa5ac68bc72778e6659ec5d

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
