FROM ubuntu:19.10

ENV DEBIAN_FRONTEND=noninteractive

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
                    -y && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    curl -L https://github.com/hasura/graphql-engine/raw/master/cli/get.sh | bash && \
    mkdir -p $HOME/.oh-my-zsh/completions && \
    hasura completion zsh --file=$HOME/.oh-my-zsh/completions/_hasura

ENTRYPOINT [ "zsh" ]
