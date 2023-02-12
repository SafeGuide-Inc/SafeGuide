import { makeExecutableSchema } from "https://deno.land/x/graphql_tools@0.0.2/mod.ts";

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