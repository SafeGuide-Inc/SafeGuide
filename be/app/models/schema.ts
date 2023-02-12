import { makeExecutableSchema } from "https://deno.land/x/graphql_tools@0.0.2/mod.ts";
import { PrismaClient } from './prisma-deno-deploy/generated/client/deno/edge.ts'

const prisma = new PrismaClient()

const typeDefs = `
  type User {
    email: String!
    name: String
  }

  type Query {
    allUsers: [User!]!
  }
`;

const resolvers = {
  Query: {
    allUsers: () => {
      return prisma.user.findMany();
    }
  }
};

export const schema = makeExecutableSchema({ resolvers, typeDefs });