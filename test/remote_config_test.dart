import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:kronogram/services/remote_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('RemoteConfig, ', () {
    test('getValue should return the correct test string', () async {
      expect(await getValue('test_config'), 'testtest');
    });
  });
}
