import 'package:safeguide/screens/login/activate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

final supabase = Supabase.instance.client;
final User? loggedUser = supabase.auth.currentUser;

void authUser(String? email, context) async {
  await supabase.auth
      .signInWithOtp(
        email: email!,
      )
      .then((value) =>
          Navigator.pushNamed(context, '/login', arguments: {'email': email}));
}

Future<void> validateAccess(
    String email, String token, BuildContext context) async {
  print(email + ' ' + 'token: ' + token);
  final response = await supabase.auth
      .verifyOTP(email: email, token: token, type: OtpType.magiclink);

  print(response);
  print(response.user?.id);
  print(response.user?.email);

  final user = response.user;

  if (user != null) {
    String userId = user.id;
    await storeUserId(userId).then((value) => Navigator.pushNamed(
        context, '/home',
        arguments: {'userId': userId, 'email': email}));
  } else {
    print('Error validating user');
  }
}

Future<void> storeUserId(String userId) async {
  await storage.write(key: 'userId', value: userId);
}
