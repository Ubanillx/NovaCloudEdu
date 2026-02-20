FROM golang:1.22-alpine AS builder

WORKDIR /app

# 复制源码
COPY . .

# 解决依赖并构建
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -o /rtc-service ./cmd/server

# 运行阶段
FROM alpine:3.19

RUN apk --no-cache add ca-certificates curl

WORKDIR /app
COPY --from=builder /rtc-service .

EXPOSE 8300

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
    CMD curl -f http://localhost:8300/health || exit 1

ENTRYPOINT ["./rtc-service"]
