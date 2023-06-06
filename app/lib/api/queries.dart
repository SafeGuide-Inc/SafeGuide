const String getIncidenceTypeList = '''
      query GetIncidenceTypeList {
        getIncidenceTypeList {
          category
          description
          id
          name
        }
      }
    ''';

const String getAllIncidencesQuery = r'''
    query GetAllIncidences {
      getAllIncidences {
        date
        existsVotes
        id
        lat
        long
        userId
        incidenceType {
          category
          description
          id
          name
        }
      }
    }
  ''';
