import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql('''
            query ExampleQuery(\$userId: ID!) {
              user(id: \$userId) {
                firstName
              }
            }
          '''),
          variables: const {
            'userId': '1',
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading');
          }

          final firstName = result.data?['user']?['firstName'];

          return Text('Hello $firstName');
        },
      ),
    );
  }
}
