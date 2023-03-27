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
    id: ID!
  }
  type Query {
    getUser(id: ID!): User
    getAllUsers: [User]
  }
  type Mutation {
    createUser(firstName: String!, lastName: String!, email: String!, phoneNumber: String!, organizationId: String!, status: String!, updatedAt: DateTime! ): User!
  }

`;

// TODO: Let's get some typing here...
export const resolvers = {
    Query: {
        getUser: async (_parent: any, { id }: any) => {
            return prisma.user.findUnique({ where: { id } });
        },
        getAllUsers() {
            return prisma.user.findMany();
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
                console.log(newUser)
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
