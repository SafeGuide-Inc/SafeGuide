import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const typeDefs = `#graphql
  scalar DateTime

  type User {
    firstName: String
    lastName: String
    email: String
    phoneNumber: String
    organizationId: String
    status: String
    updatedAt: DateTime
  }
  type Query {
    user(id: ID!): User
  }
  type Mutation {
    createUser(firstName: String!, lastName: String!, email: String!, phoneNumber: String!, organizationId: String! status: String!, updatedAt: DateTime! ): User!
  }

`;

// TODO: Let's get some typing here...
export const resolvers = {
    Query: {
        user(user: any) {
            return prisma.user.findUnique(user.id);
        },
    },
    Mutation: {
        createUser: async (_parent: any, { firstName, lastName, email, phoneNumber, organizationId, status}: any) => {
            const newUser = await prisma.user.create({
                data: {
                    firstName,
                    lastName,
                    email,
                    phoneNumber,
                    organizationId,
                    status,
                    updatedAt: new Date()
                },
            })
            return newUser
        },
    },
};
