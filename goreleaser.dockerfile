ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:7c4468db5fea18a1630860619be640c4c0ad158c0d63f12951b96b7d0f5ddd62

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
