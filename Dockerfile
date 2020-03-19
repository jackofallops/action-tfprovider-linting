FROM golang:1.13

COPY entrypoint.sh /entrypoint.sh

WORKDIR /tmp/go

ENTRYPOINT [ "/entrypoint.sh" ]