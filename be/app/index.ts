import { ApolloServer } from '@apollo/server'
import { startStandaloneServer } from '@apollo/server/standalone'
import { schema } from './models/schema.js'
import { ApolloServerErrorCode } from '@apollo/server/errors';

// const schema = makeExecutableSchema({ typeDefs, resolvers });
// The ApolloServer constructor requires two parameters: your schema
// definition and your set of resolvers.
const server = new ApolloServer({
  schema,
  formatError: (formattedError, error) => {
    // Return a different error message
    if (
      formattedError?.extensions?.code ===
      ApolloServerErrorCode.GRAPHQL_VALIDATION_FAILED
    ) {
      return {
        ...formattedError,
        message: "Your query doesn't match the schema. Try double-checking it!",
      };
    }

    // Otherwise return the formatted error. This error can also
    // be manipulated in other ways, as long as it's returned.
    return formattedError;
  },
});

// Passing an ApolloServer instance to the `startStandaloneServer` function:
//  1. creates an Express app
//  2. installs your ApolloServer instance as middleware
//  3. prepares your app to handle incoming requests
const { url } = await startStandaloneServer(server, {
  listen: { port: 4000 },
});

console.log(`🍝  Server ready at: ${url}`);
