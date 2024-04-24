ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:611d30d7f6d9992c37b1e1a212eefdf1f7c671deb56db3707e24eb01da8c4c2a

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
