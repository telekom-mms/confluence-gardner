ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:c925d12234f8d3fbef2256012b168004d4c47a82c4f06afcfd06fd208732fbe0

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
