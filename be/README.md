# GraphQL Server Setup
1. run `npm install prisma -g` to install prisma if you don't have it already
2. run `npm run local-dev`
3. navigate to localhost:4000 to view the graphQL server

# Notes
- Your environment should update with changes inside the app directory
- If you make changes outside the app directory and need them reflected in the docker container run `npm run local-dev:rebuild` and then run `npm run local-dev`
