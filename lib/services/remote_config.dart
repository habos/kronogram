import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';


  Future<String> getValue(String key) async{
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(hours: 1));
      await remoteConfig.activateFetched();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be '
              'used');
    }


    return remoteConfig.getString(key);
  }

  Future<TwitterLogin> getTwitterLogin() async{
    String key = await getValue('twitter_key');
    String secret = await getValue('twitter_secret');
    return new TwitterLogin(consumerKey: key, consumerSecret: secret);
  }
