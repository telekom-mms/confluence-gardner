ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:8c8b7cf2a01e2d1c683128b2488d77139fa90ec8cb807f0ae260d57f7022dedd

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
