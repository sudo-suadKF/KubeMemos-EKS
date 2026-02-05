FROM golang:1.25-alpine as builder

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates && \
adduser -u 1001 -D nonroot

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build go build -trimpath -ldflags="-s -w" -o memos . ./cmd/memos

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app/memos /usr/local/memos/memos

USER nonroot

WORKDIR /var/opt/memos

VOLUME /var/opt/memos

EXPOSE 5230

ENTRYPOINT ["/memos"]