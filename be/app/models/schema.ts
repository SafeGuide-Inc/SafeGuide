import { makeExecutableSchema } from "https://deno.land/x/graphql_tools@0.0.2/mod.ts";
import { gql } from "https://deno.land/x/graphql_tag@0.0.1/mod.ts";

const typeDefs = gql`
  type Query {
    hello: String
  } 
`;
const resolvers = {
  Query: {
    hello: (_root: undefined, _args: unknown, ctx: { request: Request }) => {
      return `Hello World! from ${ctx.request.url}`;
    },
  },
};

export const schema = makeExecutableSchema({ resolvers, typeDefs });