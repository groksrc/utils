FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.pyenv/bin:$PATH"

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install apt-utils \
                    curl \
                    dnsutils \
                    git \
                    iputils-ping \
                    net-tools \
                    postgresql \
                    wget \
                    zsh \
                    vim \
                    tzdata \
                    nginx \
                    software-properties-common \
                    build-essential \
                    zlib1g-dev \
                    libffi-dev \
                    libssl-dev \
                    python3-venv \
                    libaugeas0 \
                    -y && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    curl -L https://github.com/hasura/graphql-engine/raw/master/cli/get.sh | bash && \
    mkdir -p $HOME/.oh-my-zsh/completions && \
    hasura completion zsh --file=$HOME/.oh-my-zsh/completions/_hasura

RUN python3 -m venv /opt/certbot/ && \
    /opt/certbot/bin/pip install --upgrade pip && \
    /opt/certbot/bin/pip install certbot certbot-nginx && \
    ln -s /opt/certbot/bin/certbot /usr/bin/certbot

ENTRYPOINT [ "zsh" ]
