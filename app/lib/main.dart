import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:safeguide/components/successReport.dart';
import 'package:safeguide/screens/home/report.dart';
import 'package:safeguide/screens/profile/account.dart';
import 'package:safeguide/screens/profile/notifications.dart';
import 'package:safeguide/screens/profile/sessionclose.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:safeguide/screens/home/home.dart';

import 'package:safeguide/screens/login/home.dart';
import 'package:safeguide/screens/login/login.dart';
import 'package:safeguide/screens/login/activate.dart';
import 'package:safeguide/screens/login/signup.dart';
import 'package:safeguide/screens/test.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://scmtwxdvsullwsfpzhcp.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNjbXR3eGR2c3VsbHdzZnB6aGNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjkxNjU0MzMsImV4cCI6MTk4NDc0MTQzM30.vRghy38_90SkkOP-6LL5LicsFI-ehf_gp6oSMIBxmYQ');

  final HttpLink httpLink = HttpLink(
    dotenv.env['API_URL']!,
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ),
  );

  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GraphQLProvider(
        client: client,
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const Main(),
            //'/': (context) => GraphExampleScreen(),
            '/loginHome': (context) => const LoginHome(),
            '/login': (context) => const Login(),
            '/activation': (context) => const Activation(),
            '/signup': (context) => const SignUp(),
            '/home': (context) => const Home(),
            '/report': (context) => ReportIncident(),
            '/reportSuccess': (context) => SuccessScreen(),
            '/userAccount': (context) => const UserAccount(),
            '/notifications': (context) => UserNotifications(),
            '/closeSession': (context) => const SessionClose(),
          },
        ),
      );
    }),
  );
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loggedUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/loginHome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color(0xff1c1e21),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
