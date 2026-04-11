ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:c83f022002fc917a92501a8c30c605efdad3010157ba2c8998a2cbf213299201

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
