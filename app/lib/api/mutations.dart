const String createUser = r'''
mutation CreateUser($firstName: String!, $lastName: String!, $email: String!, $phoneNumber: String!, $organizationId: String!, $status: String!, $supabaseId: String!) {
  createUser(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, organizationId: $organizationId, status: $status, supabaseId: $supabaseId) {
    email
    firstName
    id
    lastName
    phoneNumber
    status
    supabaseId
    updatedAt
    organizationId
  }
}
''';

const String createIncident = r'''
mutation Mutation($lat: String!, $long: String!, $userId: String!, $incidenceTypeId: String!, $date: DateTime!) {
  createIncidence(lat: $lat, long: $long, userId: $userId, incidenceTypeId: $incidenceTypeId, date: $date) {
    lat
    long
    userId
    incidenceTypeId
    date
  }
}
''';
