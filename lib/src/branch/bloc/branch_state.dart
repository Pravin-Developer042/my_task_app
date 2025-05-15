part of 'branch_bloc.dart';

abstract class BranchState {}

class BranchLoading extends BranchState {}

class BranchLoaded extends BranchState {
  final List<AllDataModel> branchCommits;
  BranchLoaded(this.branchCommits);
}

class BranchError extends BranchState {
  final String message;
  BranchError(this.message);
}
