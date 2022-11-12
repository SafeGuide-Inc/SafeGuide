FROM denoland/deno:latest as base

WORKDIR /be/app

COPY . ./

RUN deno cache server.ts

CMD ["run", "--allow-net", "server.ts"]