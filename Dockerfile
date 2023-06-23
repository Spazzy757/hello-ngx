ARG NGX_VERSION=1.25.1
ARG NGX_DEBUG=true

FROM rust:alpine3.18 as builder
ARG NGX_VERSION
ARG NGX_DEBUG
RUN apk --no-cache add \
      clang \
      libc-dev \
      binutils \
      linux-headers \
      make \
      perl \
      clang-dev

WORKDIR /hello-ngx

COPY ./Cargo.lock .
COPY ./Cargo.toml .

COPY ./src ./src

#https://zhuanlan.zhihu.com/p/138109387
RUN RUSTFLAGS="-C target-feature=-crt-static" cargo build

FROM nginx:${NGX_VERSION}-alpine

RUN apk add --no-cache libstdc++ gcc g++

COPY --from=builder /hello-ngx/target/debug/libhello_ngx.so /etc/nginx/modules/libhello_ngx.so

