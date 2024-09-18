ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:88e0a2ac7c9b54f1ef941e7978c21fd45b46cc6e768f4bc28f3618a51438dc5d

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
