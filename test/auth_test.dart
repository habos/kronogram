import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:mockito/mockito.dart';

class mockAuth extends Mock implements Auth{
  int id;
}

class mockResult extends Mock implements AuthResult{

}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Auth, ', () {
    test('Test user login and logout', () async {
      Auth auth = new Auth();
      AuthResult uid1 = await auth.signUp('email1@email.com', 'password');
      AuthResult uid2 = await auth.signUp('email2@email.com', 'password2');
      AuthResult uid1In = await auth.signIn('email1@email.com', 'password');
      AuthResult uid2In = await auth.signIn('email2@email.com', 'password2');
      expect(uid1.user, uid1In.user);
      expect(uid2.user, uid2In.user);
    });
  });
}
