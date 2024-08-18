FROM golang:1.22-alpine
RUN apk update && apk add --no-cache make curl
RUN mkdir /go/src/app/
WORKDIR /go/src/app/
COPY ./ /go/src/app/

RUN curl -sSf https://atlasgo.sh | sh
RUN go get github.com/golang-migrate/migrate/v4/cmd/migrate
RUN make tidy

RUN make migrate-reset

ENTRYPOINT [ "go", "run", "./api/" ]
