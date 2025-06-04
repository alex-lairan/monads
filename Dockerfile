FROM crystallang/crystal:1.6.0

WORKDIR /app
COPY . /app
RUN shards install

CMD ["crystal", "spec"]
