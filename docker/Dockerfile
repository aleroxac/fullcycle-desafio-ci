FROM golang:1.19.4-alpine3.17 AS base


FROM base as build
WORKDIR /build
COPY . /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o math


FROM scratch as main
WORKDIR /app
COPY --from=build /build/math /app/math
ENTRYPOINT [ "/app/math" ]