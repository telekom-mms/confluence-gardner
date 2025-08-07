ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:1951bedd9ab20dd71a5ab11b3f5a624863d7af4109f299d62289928b9e311d5d

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY confluence-gardner /confluence-gardner

# Run the hello binary.
ENTRYPOINT ["/confluence-gardner"]
