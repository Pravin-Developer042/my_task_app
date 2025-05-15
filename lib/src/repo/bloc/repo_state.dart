part of 'repo_bloc.dart';

abstract class RepoState {}

class RepoLoading extends RepoState {}

class RepoLoaded extends RepoState {
  final List<RepoModel> repos;
  RepoLoaded(this.repos);
}

class RepoError extends RepoState {
  final String message;
  RepoError(this.message);
}
