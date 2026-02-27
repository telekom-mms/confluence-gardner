ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:97406725e9ca912013f59ae49fa3362d44f2745c07eba00705247216225b810c

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
