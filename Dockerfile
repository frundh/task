FROM ubuntu
ARG COMPOSE_VERSION=1.24.0
RUN set -ex; \
    apt-get update; \
    apt-get -y install --no-install-recommends apt-utils 2>&1; \
    #
    # Install Docker CE CLI
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common lsb-release; \
    curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | (OUT=$(apt-key add - 2>&1) || echo $OUT); \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable"; \
    apt-get update; \
    apt-get install -y docker-ce-cli; \
    #
    # Install Docker Compose
    curl -sSL "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
    chmod +x /usr/local/bin/docker-compose; \
    #
    # Install Task
    curl -sL https://taskfile.dev/install.sh | sh; \
    #
    # Clean up
    apt-get autoremove -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*;

ENTRYPOINT [ "task" ]
CMD [ "--help" ]