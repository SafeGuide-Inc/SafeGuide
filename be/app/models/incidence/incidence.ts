import { incidence, PrismaClient } from '@prisma/client';
import { Point } from './types';

const prisma = new PrismaClient();

export const typeDefs = `#graphql
  scalar DateTime

  type IncidenceType {
    id: ID!
    name: String
    description: String
  }

  input Point {
    lat: String
    long: String
  }

  type Incidence {
    id: ID!
    lat: String
    long: String
    userId: String
    IncidenceType: IncidenceType
    existsVotes: Int
    date: DateTime
  }
  type Query {
    getIncidence(id: ID!): Incidence
    getIncidencesWithinRangeInMiles(radiusInMeters: Float!, center: Point!): [Incidence]
  }
  type Mutation {
   createIncidence(lat: String!, long: String!, userId: String!, incidenceTypeId: String!, date: DateTime!): Incidence!
   incidentVote(id: ID!, exists: Boolean!): Incidence!
   incidentExistsVote(id: ID!, stillExists: Boolean!): Incidence!
  }

`;

export const resolvers = {
    Query: {
        getIncidence: async (_parent: any, { id }: any) => {
            return prisma.incidence.findUnique({
                include: {
                    incidenceType: true,
                },
                where: { id }
            });
        },
        getIncidencesWithinRangeInMiles: async (_: any, { radiusInMeters, center }: { radiusInMeters: number; center: Point }): Promise<incidence[]> => {
            const { lat, long } = center;
            // 69 miles per degree of latitude (or longitude) this is 
            // a rough approximation because the earth is not a perfect sphere
            const incidencesWithinCircle: incidence[]  = await prisma.$queryRaw`
                    SELECT *
                    FROM "Incidence"
                    JOIN ON "Incidence"."incidenceTypeId" = "IncidenceType"."id"
                    WHERE ST_DWithin(
                      ST_GeographyFromText('SRID=4326;POINT(${long} ${lat})'),
                      location,
                      ${radiusInMeters}
                    )
           `                   
            return incidencesWithinCircle;
        },
    },

    Mutation: {
        createIncidence: async (_parent: any, { lat, long, userId, incidenceTypeId, date }: any) => {
            try {
                const newIncidence = await prisma.incidence.create({
                    data: {
                        lat,
                        long,
                        userId,
                        incidenceTypeId,
                        date,
                    },
                })
                return newIncidence
            } catch (error: any) {
                console.error(error);
            }
        },
        incidentExistsVote: async (_parent: any, { id, stillExists }: any) => {
            try {
                const incidence = await prisma.incidence.findUnique({ where: { id } });
                if (!incidence) return new Error('Incidence not found');
                let vote = stillExists ? 1 : -1;
                const updatedIncidence = await prisma.incidence.update({
                    where: { id },
                    data: {
                        existsVotes: incidence.existsVotes + vote
                    },
                })
                return updatedIncidence
            } catch (error: any) {
                console.error(error);
            }
        },
    },
};
