docker-compose up -d
wait
prisma migrate deploy --schema=./app/prisma/schema.prisma
