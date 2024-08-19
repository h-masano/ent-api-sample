FROM golang:1.22-alpine
RUN apk update && apk add --no-cache make curl
RUN mkdir /go/src/app/
WORKDIR /go/src/app/
COPY ./ /go/src/app/

RUN curl -sSf https://atlasgo.sh | sh
RUN make tidy

ENTRYPOINT [ "sh", "docker-entorypoint.sh" ]
