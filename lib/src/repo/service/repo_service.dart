import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../auth/service/auth_service.dart';
import '../models/repo_model.dart';

class RepoService {
  static Future<List<RepoModel>> getRepositories() async {
    try {
      final token = await AuthService.getStoredToken();
      debugPrint(token);
      final res = await http.get(
        Uri.parse('https://api.github.com/user/repos'),
        headers: {'Authorization': 'token $token'},
      );
      debugPrint("sssss${res.body}", wrapWidth: 1024);
      if (res.statusCode != 200) throw Exception('Failed to fetch repos');
      return repoModelFromJson(res.body);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
