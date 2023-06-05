import { makeExecutableSchema } from '@graphql-tools/schema';
import * as userSchema from './users/users.js'
import * as incidenceSchema from './incidence/incidence.js'

export const schema = makeExecutableSchema({
  typeDefs: [
    userSchema.typeDefs,
    incidenceSchema.typeDefs,
  ],
  resolvers: [
    userSchema.resolvers,
    incidenceSchema.resolvers,
  ]
})
