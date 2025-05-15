import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/src/branch/models/all_data_model.dart';
import 'package:my_task_app/src/branch/service/branch_service.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchLoading()) {
    on<FetchBranchesAndCommits>(_fetchBranch);
  }
  void _fetchBranch(
    FetchBranchesAndCommits event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchLoading());
    try {
      final branches = await BranchService.getBranches(event.owner, event.repo);
      final List<AllDataModel> data = [];
      for (var branch in branches) {
        final commits = await BranchService.getCommits(
          event.owner,
          event.repo,
          branch.name ?? "",
        );
        data.add(AllDataModel(branches: branch, commits: commits));
      }
      emit(BranchLoaded(data));
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }
}
