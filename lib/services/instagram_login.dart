import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:developer';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kronogram/services/remote_config.dart';

Future waitWhile(bool test(),
    [Duration pollInterval = const Duration(microseconds: 1)]) {
  var completer = new Completer();
  check() {
    if (!test()) {
      completer.complete();
    } else {
      new Timer(pollInterval, check);
    }
  }

  check();
  return completer.future;
}

Future<Token> getToken() async {
  String appId = await getValue('instagram_id');
  String appSecret = await getValue('instagram_secret');
  String redirectURI = "https://habos.github.io/kronogram/";
  String code = '';
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=$redirectURI&scope=user_profile,user_media&response_type=code";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url);
  flutterWebviewPlugin.onUrlChanged.listen((String url) {
    if (url.contains("?code=")) {
      log("This is the url with the auth code");
      log(url);
      code = url.substring(
        url.indexOf('code=') + 5,
        url.indexOf('#_'),
      );
      flutterWebviewPlugin.close();
    }
  });
  await waitWhile(() => (code == ''));
  log(code);
  final http.Response response =
      await http.post("https://api.instagram.com/oauth/access_token", body: {
    "client_id": appId,
    "client_secret": appSecret,
    "grant_type": "authorization_code",
    "redirect_uri": redirectURI,
    "code": code
  });
  log("Trying to see whats in the response:");
  log(response.body);
  return new Token.fromMap(JSON.jsonDecode(response.body));
}

class Token {
  var access;
  var id;

  Token.fromMap(Map json) {
    access = json['access_token'];
    id = json['user_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'token': access,
      'userId': id,
    };
  }
}
