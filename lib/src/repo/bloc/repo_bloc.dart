import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/src/repo/service/repo_service.dart';

import '../models/repo_model.dart';

part 'repo_event.dart';
part 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc() : super(RepoLoading()) {
    on<FetchRepos>(fetchRepoList);
  }
  void fetchRepoList(FetchRepos event, Emitter<RepoState> emit) async {
    emit(RepoLoading());
    try {
      final repos = await RepoService.getRepositories();
      emit(RepoLoaded(repos));
    } catch (e) {
      emit(RepoError(e.toString()));
    }
  }
}
