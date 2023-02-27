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
        createUser: async (_parent: any, { firstName, lastName, email, phoneNumber, organizationId, status }: any) => {
            try {
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
            } catch (error: any) {
                if (error.code === 'P2002') {
                    console.log(error)
                    // Handle unique constraint violation error
                    return new Error('Email already exists');
                } else {
                    // Handle other errors
                    return new Error('Something went wrong');
                }
            }

        },
    },
};