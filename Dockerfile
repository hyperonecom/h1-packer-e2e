FROM golang:1.12-alpine
ENV H1_CLI_VERSION="v1.4.0"
ENV PACKER_REPO="github.com/hashicorp/packer"
ENV PACKER_BRANCH="master"
ENV PATH=/go/packer/bin/:$PATH

# Setup
RUN apk add curl bats git make gcc musl-dev findutils grep
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/download/${H1_CLI_VERSION}/h1-alpine" -o /bin/h1 \
&& chmod +x /bin/h1

# Download
RUN git clone "https://${PACKER_REPO}.git" -b "${PACKER_BRANCH}" --single-branch --depth 1 "/go/src/${PACKER_REPO}/"

# Build
WORKDIR "/go/src/${PACKER_REPO}"
RUN make dev
CMD ["packer"]
