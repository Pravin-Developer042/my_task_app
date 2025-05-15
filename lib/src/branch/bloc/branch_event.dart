part of 'branch_bloc.dart';

abstract class BranchEvent {}

class FetchBranchesAndCommits extends BranchEvent {
  final String owner;
  final String repo;
  FetchBranchesAndCommits({required this.owner, required this.repo});
}
