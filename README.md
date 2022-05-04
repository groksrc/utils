# groksrc/utils

This is a simple ubuntu container that has a few commonly used programs.

It sets up tzdata first because postgresql requires it and configures America/Chicago.

Tools:
* curl
* dnsutils
* git
* hasura (with autocomplete via Oh-my-zsh)
* iputils-ping
* net-tools
* postgresql
* wget
* zsh (with Oh-my-zsh)
* vim

## run
k run utils --tty --stdin --image=groksrc/utils:latest

## helm install

```
$ helm install utils ./utils --set pvcName=your_pvc_name -n your_namespace
```
