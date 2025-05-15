import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/utils/helpers/no_data_widget.dart';
import 'package:my_task_app/utils/helpers/page_loader.dart';

import '../bloc/repo_bloc.dart';
import '../../branch/views/repo_detail_screen.dart';
import 'drawer.dart';

class RepoListScreen extends StatelessWidget {
  final String token;
  const RepoListScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepoBloc()..add(FetchRepos()),
      child: Scaffold(
        appBar: AppBar(title: Text("Your Repositories")),
        drawer: const AppDrawer(),
        body: BlocBuilder<RepoBloc, RepoState>(
          builder: (context, state) {
            if (state is RepoLoading) return pageLoader();
            if (state is RepoLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.repos.length,
                  itemBuilder: (context, index) {
                    final repo = state.repos[index];
                    return Card(
                      child: ListTile(
                        title: Text(repo.name ?? ""),
                        subtitle: Text(
                          "Visibility: ${repo.private! ? 'Private' : 'Public'}",
                        ),
                        trailing: Text("Branch: ${repo.defaultBranch}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => RepoDetailScreen(
                                    repo: repo.name ?? "",
                                    owner: repo.owner!.login ?? "",
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return noDataWidget();
          },
        ),
      ),
    );
  }
}
