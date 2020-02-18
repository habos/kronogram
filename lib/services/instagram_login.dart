import 'dart:async';
import 'dart:convert' as JSON;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Token> getToken(String appId, String appSecret) async {
  String redirectURI = "https://habos.github.io/kronogram/";
  Stream<String> onCode = await _server();
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=$redirectURI&scope=user_profile&response_type=code";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url);
  final String code = await onCode.first;
  final http.Response response = await http.post(
      "https://api.instagram.com/oauth/access_token",
      body: {"client_id": appId, "client_secret": appSecret, "grant_type": "authorization_code", "redirect_uri": redirectURI,
        "code": code});
  flutterWebviewPlugin.close();
  return new Token.fromMap(JSON.jsonDecode(response.body));
}

Future<Stream<String>> _server() async {
  final StreamController<String> onCode = new StreamController();
  HttpServer server =
  await HttpServer.bind(InternetAddress.loopbackIPv4, 8585);
  server.listen((HttpRequest request) async {
    final String code = request.uri.queryParameters["code"];
    request.response
      ..statusCode = 200
      ..headers.set("Content-Type", ContentType.html.mimeType)
      ..write("<html><h1>You can now close this window</h1></html>");
    await request.response.close();
    await server.close(force: true);
    onCode.add(code);
    await onCode.close();
  });
  return onCode.stream;
}

class Token {
  String access;
  String id;

  Token.fromMap(Map json){
    access = json['access_token'];
    id = json['user_id'];
  }
}
