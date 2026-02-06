FROM node:25-alpine AS frontend

WORKDIR /web

COPY web/ .

RUN npm install
RUN npm install -g vite
RUN npm run release

FROM golang:1.25-alpine AS backend

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates && \
adduser -u 1001 -D nonroot

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

COPY --from=frontend /server/router/frontend/dist ./server/router/frontend/dist

RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build go build -trimpath -ldflags="-s -w" -o memos ./cmd/memos

FROM scratch

COPY --from=backend /etc/passwd /etc/passwd
COPY --from=backend /app/memos /usr/local/bin/memos
COPY --from=backend /app/server/router/frontend/dist ./server/router/frontend/dist

USER nonroot

WORKDIR /var/opt/memos

VOLUME /var/opt/memos

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/memos"]
