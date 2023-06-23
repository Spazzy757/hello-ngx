# Hello NGINX Rust Module

This is a small POC to build a Dynamic Nginx Rust module using rust. This is
heavily influenced from the curl examples used in [ngx-rust][1] crate but is
used as a learning tool to see how the different components interact for
beginners. 

## Getting Started

We run a simple docker compose setup injecting a custom
[nginx.conf](config/nginx.conf) into the container. Therefore all you need to
do is run:

```bash
docker compose up -d
```
> Note this will probably take a fair amount of time

## Testing how the Module Works

You can test how the module works by making the following curl requests:

```bash
curl http://127.0.0.1:8000 -v -H "user-agent: hello-ngx"
```

While this will return a simple 200 status code if you look in the NGINX 
logs you will see a little surprise

```logs
...
2023/06/23 10:34:26 [debug] 1#1: *1 hello world module enabled: true
2023/06/23 10:34:26 [debug] 1#1: *1 Hello Rusty NGINX
...
```

## Files of Note

There are two files to look into;

- [hello_ngx.rs](src/hello_ngx.rs): This is the custom module that gets
  created
- [nginx.conf](config/nginx.conf): This is the nginx configuration that makes
  use of the custom nginx module

[1]: https://github.com/nginxinc/ngx-rust
