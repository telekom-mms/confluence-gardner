ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:f5e95195e998742ff590b7569bae479accce1226e51ae6c3118954030121cdcb

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
