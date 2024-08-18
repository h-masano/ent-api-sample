FROM golang:1.22-alpine
RUN apk update && apk add --no-cache make
RUN mkdir /go/src/app/
WORKDIR /go/src/app/
COPY ./ /go/src/app/

# RUN go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
RUN make tidy

ENTRYPOINT [ "go", "run", "./api/" ]
