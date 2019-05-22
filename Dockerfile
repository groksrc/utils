FROM ubuntu:19.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install tzdata && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt install curl \
                dnsutils \
                git \
                net-tools \
                postgresql \
                wget \
                zsh \
                -y && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ENTRYPOINT [ "zsh" ]