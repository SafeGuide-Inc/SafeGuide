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

  type Device {
    userId: String
    deviceToken: String
    os: String

  }

  type Query {
    getUser(id: ID!): User
    getAllUsers: [User]
    getDevice(userId: ID!): Device
  }

  type Mutation {
    createUser(firstName: String!, lastName: String!, email: String!, phoneNumber: String!, organizationId: String!, status: String!, supabaseId: String!): User!
    deleteUser(id: ID!): User
    addDevice(userId: ID!, deviceToken: String, os: String): Device
  }

`;

// TODO: Let's get some typing here...
export const resolvers = {
    Query: {
        getUser: async (_parent: any, { id }: any) => {
            return prisma.user.findUnique({ where: { id } });
        },
        getDevice: async (_parent: any, { id }: any) => {
            const devices = await prisma.device.findMany({ where: {
                userId: id 
            }});
            return devices[0];
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
        addDevice: async (_parent: any, { userId, os, deviceToken }: any) => {
            try {
                const newDevice = await prisma.device.create({
                    data: {
                        userId: userId,
                        os: os,
                        deviceToken: deviceToken,
                    },
                })
                return newDevice
            } catch (error: any) {
                // Handle other errors
                console.log(error)
                throw new Error('Something went wrong');
            }
        },
        deleteUser: async (_parent: any, { id }: any) => {
            try {
                const userDeleted = await prisma.user.delete({
                    where: {
                        id
                    },
                })
                return userDeleted
            } catch (error: any) {
                console.log(error)
                // Handle other errors
                throw new Error('Something went wrong');
            }
        },
    },
};
