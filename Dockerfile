FROM golang:1.12-alpine
ENV H1_CLI_VERSION="v1.4.0"
ENV PACKER_REPO_URL="https://github.com/hashicorp/packer.git"
ENV PACKER_BRANCH="master"

# Setup
RUN apk add curl bats git make gcc musl-dev findutils grep
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/download/${H1_CLI_VERSION}/h1-alpine" -o /bin/h1 \
&& chmod +x /bin/h1
RUN git clone "${PACKER_REPO_URL}" -b "${PACKER_BRANCH}" --single-branch --depth 1
WORKDIR /go/packer

# Build
RUN make dev
ENV PATH=/go/packer/bin/:$PATH

# Build
CMD ["packer"]
