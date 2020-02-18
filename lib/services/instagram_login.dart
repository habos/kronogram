import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:developer';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Token> getToken(String appId, String appSecret) async {
  String redirectURI = "https://habos.github.io/kronogram/";
  String code = '';
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=$redirectURI&scope=user_profile&response_type=code";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url);
  flutterWebviewPlugin.onUrlChanged.listen((String url){
    log(url);
    if(url.contains("?code=")) {
      code = url.substring(url.indexOf('code=') + 5,
          url.indexOf('#_'),);
      flutterWebviewPlugin.close();
    }
  }
  );
  final http.Response response = await http.post(
      "https://api.instagram.com/oauth/access_token",
      body: {"client_id": appId, "client_secret": appSecret, "grant_type": "authorization_code", "redirect_uri": redirectURI,
        "code": code});
  return new Token.fromMap(JSON.jsonDecode(response.body));
}

class Token {
  String access;
  String id;

  Token.fromMap(Map json){
    access = json['access_token'];
    id = json['user_id'];
  }
}
