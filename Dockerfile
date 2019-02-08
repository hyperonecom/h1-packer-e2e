FROM golang
ENV H1_CLI_VERSION="v1.4.0"
ENV PACKER_BRANCH="hyperone"

# Setup
RUN apt-get update \
&& apt-get install bats \
&& rm -rf /var/lib/apt/lists/*
# RUN curl -s -L $(curl -s -L "https://api.github.com/repos/hyperonecom/h1-cli/releases/${H1_CLI_VERSION}" | sed -E -n 's/.*browser_download_url": *"(.*h1-linux)".*/\1/p') -o /bin/h1 \
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/download/${H1_CLI_VERSION}/h1-linux" -o /bin/h1 \
&& chmod +x /bin/h1
RUN git clone https://github.com/hyperonecom/packer.git -b "${PACKER_BRANCH}" --single-branch --depth 1
WORKDIR /go/packer

# Build
RUN make dev
ENV PATH=/go/packer/bin/:$PATH

# Build
CMD ["packer"]
