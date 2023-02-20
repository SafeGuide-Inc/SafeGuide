FROM node:14

COPY . .

RUN yarn install
RUN yarn prisma generate
RUN apt-get update
RUN apt-get install -y vim

EXPOSE 4000

CMD ["yarn", "start"]