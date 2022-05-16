# syntax=docker.io/docker/dockerfile:1.4.1

FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.pyenv/bin:$PATH"

COPY <<HTML /html/default.html
<html>
  <head>
    <title>Test</title>
  </head>
  <body>
    Test
  </body>
</html>
HTML

RUN <<INSTALL
apt-get update
apt-get -y upgrade
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
                -y

ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
dpkg-reconfigure --frontend noninteractive tzdata && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

python3 -m venv /opt/certbot/
/opt/certbot/bin/pip install --upgrade pip
/opt/certbot/bin/pip install certbot certbot-nginx
ln -s /opt/certbot/bin/certbot /usr/bin/certbot

echo "export NVM_DIR=\"$HOME/.nvm\"" >> $HOME/.zshrc
echo "[ -s \"$HOME/.nvm/nvm.sh\" ] && \. \"$HOME/.nvm/nvm.sh\"  # This loads nvm" >> $HOME/.zshrc
echo "[ -s \"$HOME/.nvm/bash_completion\" ] && \. \"$HOME/.nvm/bash_completion\"  # This loads nvm bash_completion" >> $HOME/.zshrc

INSTALL

EXPOSE 3000
ENTRYPOINT [ "zsh" ]
