import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_task_app/src/branch/models/commits_model.dart';

import '../../auth/service/auth_service.dart';
import '../models/branch_model.dart';

class BranchService {
  static Future<List<BranchModel>> getBranches(
    String owner,
    String repo,
  ) async {
    try {
      final token = await AuthService.getStoredToken();
      debugPrint('https://api.github.com/repos/$owner/$repo/branches');
      final res = await http.get(
        Uri.parse('https://api.github.com/repos/$owner/$repo/branches'),
        headers: {'Authorization': 'token $token'},
      );

      if (res.statusCode != 200) throw Exception('Failed to fetch branches');

      return branchModelFromJson(res.body);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<CommitsModel>> getCommits(
    String owner,
    String repo,
    String branch,
  ) async {
    try {
      final token = await AuthService.getStoredToken();
      debugPrint(
        "https://api.github.com/repos/$owner/$repo/commits?sha=$branch&per_page=5",
      );
      final res = await http.get(
        Uri.parse(
          'https://api.github.com/repos/$owner/$repo/commits?sha=$branch&per_page=5',
        ),
        headers: {'Authorization': 'token $token'},
      );

      if (res.statusCode != 200) throw Exception('Failed to fetch commits');

      return commitsModelFromJson(res.body);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
