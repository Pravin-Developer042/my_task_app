import 'branch_model.dart';
import 'commits_model.dart';

class AllDataModel {
  final BranchModel branches;
  final List<CommitsModel> commits;

  AllDataModel({required this.branches, required this.commits});
}
