ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:007fbc0e0df2f12b739e9032a45ade4c58be0c9981767c440da6c404418f3144

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
