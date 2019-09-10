FROM node:alpine as cli_builder
RUN apk add --no-cache libstdc++
RUN wget https://github.com/hyperonecom/h1-cli/archive/develop.tar.gz
RUN tar xvzf develop.tar.gz
WORKDIR /h1-cli-develop
RUN npm install .
RUN npx pkg -c package.json -t "node12-alpine" -o "./dist/h1" "./bin/h1"

FROM golang:1.12-alpine
COPY --from=cli_builder /h1-cli-develop/dist/h1 /bin/h1
ENV PACKER_REPO="github.com/ad-m/packer"
ENV PACKER_BRANCH="ad-m-patch-1"
ENV PATH=/go/packer/bin/:$PATH

# Setup
RUN apk add libstdc++ curl bats git make gcc musl-dev findutils grep

# Download
RUN git clone "https://${PACKER_REPO}.git" -b "${PACKER_BRANCH}" --single-branch --depth 1 "/go/src/${PACKER_REPO}/"

# Build
WORKDIR "/go/src/${PACKER_REPO}"
RUN make dev
CMD ["packer"]
