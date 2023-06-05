import { PrismaClient } from '@prisma/client';
import { v4 as uuidv4 } from 'uuid';

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
    id: String
    supabaseId: String
    updatedAt: DateTime
  }
  type Query {
    getUser(id: ID!): User
    getAllUsers: [User]
  }
  type Mutation {
    createUser(firstName: String!, lastName: String!, email: String!, phoneNumber: String!, organizationId: String!, status: String!, supabaseId: String!): User!
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
        createUser: async (_parent: any, { firstName, lastName, email, phoneNumber, organizationId, status, supabaseId }: any) => {
            try {
                const newUser = await prisma.user.create({
                    data: {
                        id: supabaseId,
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
                console.log(error)
                if (error.code === 'P2002') {
                    // Handle unique constraint violation error
                    throw new Error(error.meta.target[0] + ' already exists in the database)');
                } else {
                    // Handle other errors
                    throw new Error('Something went wrong');
                }
            }
        },
    },
};
