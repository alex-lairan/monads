FROM --platform=${TARGETPLATFORM:-linux/amd64} crystallang/crystal:1.6.0-alpine AS builder

WORKDIR /app
# Copy only shard files first to cache the shards installation
COPY shard.yml ./
RUN shards install

# Copy the rest of the application
COPY . .

FROM --platform=${TARGETPLATFORM:-linux/amd64} crystallang/crystal:1.6.0-alpine
WORKDIR /app
COPY --from=builder /app /app

CMD ["crystal", "spec"]
