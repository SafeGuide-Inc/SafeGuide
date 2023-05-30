import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Incident {
  final String name;
  final IconData icon;

  Incident(this.name, this.icon);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink(
    'http://localhost:4000/graphql',
  );

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: Scaffold(
          body: Query(
            options: QueryOptions(
              document: gql(r'''
                query IncidenceType {
                  getIncidenceTypeList {
                    category
                    description
                    id
                    name
                  }
                }
              '''),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return CircularProgressIndicator();
              }

              List<Incident> incidents = [];
              var data = result.data!['getIncidenceTypeList'];
              for (var incidentData in data) {
                IconData iconData = _getIconData(incidentData['category']);
                incidents.add(Incident(incidentData['name'], iconData));
              }

              // Now you have your incidents list, you can use it in your app.
              return ListView.builder(
                itemCount: incidents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(incidents[index].icon),
                    title: Text(incidents[index].name),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String category) {
    switch (category) {
      case 'Theft':
        return Icons.security;
      case 'Violence':
        return Icons.person;
      case 'ThreateningPerson':
        return Icons.visibility;
      case 'SuspiciousActivity':
        return Icons.report_problem;
      case 'Hazard':
        return Icons.warning;
      case 'GeneralIncident':
        return Icons.help_outline;
      case 'EmergencyResponder':
        return Icons.fire_extinguisher;
      default:
        return Icons.help;
    }
  }
}
