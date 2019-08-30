FROM golang:1.12-alpine
RUN apk add --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" h1-cli
ENV PACKER_REPO="github.com/hashicorp/packer"
ENV PACKER_BRANCH="master"
ENV PATH=/go/packer/bin/:$PATH

# Setup
RUN apk add libstdc++ curl bats git make gcc musl-dev findutils grep

# Download
RUN git clone "https://${PACKER_REPO}.git" -b "${PACKER_BRANCH}" --single-branch --depth 1 "/go/src/${PACKER_REPO}/"

# Build
WORKDIR "/go/src/${PACKER_REPO}"
RUN make dev
CMD ["packer"]
