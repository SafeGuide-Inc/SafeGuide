FROM node:lts

COPY . .

RUN yarn install
RUN apt-get update
RUN apt-get install -y vim
RUN yarn prisma generate --schema=./app/prisma/schema.prisma

EXPOSE 4000

CMD ["yarn", "start"]