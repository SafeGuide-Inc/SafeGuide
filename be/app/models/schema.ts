import { makeExecutableSchema } from '@graphql-tools/schema';
import * as userSchema from './users/users.js'

export const schema = makeExecutableSchema({
  typeDefs: [
      userSchema.typeDefs, // First defines the type Query
  ],
  resolvers: {
      ...userSchema.resolvers,
  }
})