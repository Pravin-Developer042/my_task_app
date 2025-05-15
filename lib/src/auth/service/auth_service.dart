import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';
import '../../../constants/constants.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();

  static final redirectUri = 'yourapp://auth-callback';

  static Future<String> authenticateWithGitHub() async {
    try {
      final url =
          Uri.https('github.com', '/login/oauth/authorize', {
            'client_id': AppConfig.clientId,
            'redirect_uri': redirectUri,
            'scope': 'repo user',
          }).toString();

      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: "yourapp",
        options: FlutterWebAuth2Options(useWebview: true, silentAuth: true),
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw Exception('GitHub returned no code');

      final tokenResponse = await http.post(
        Uri.parse("https://github.com/login/oauth/access_token"),
        headers: {'Accept': 'application/json'},
        body: {
          'client_id': AppConfig.clientId,
          'client_secret': AppConfig.clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      final Map<String, dynamic> tokenJson = json.decode(tokenResponse.body);
      debugPrint(tokenResponse.body.toString());
      final accessToken = tokenJson['access_token'];

      if (accessToken == null) throw Exception('Access token missing');

      await _storage.write(key: Constants.token, value: accessToken);

      return accessToken;
    } catch (e) {
      debugPrint('GitHub login error: $e');
      return '';
    }
  }

  static Future<String?> getStoredToken() async {
    return await _storage.read(key: Constants.token);
  }

  static Future<void> logout() async {
    await _storage.delete(key: Constants.token);
  }
}
