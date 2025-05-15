import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_task_app/utils/helpers/page_loader.dart';

import '../bloc/branch_bloc.dart';

class RepoDetailScreen extends StatelessWidget {
  final String owner;
  final String repo;

  const RepoDetailScreen({super.key, required this.owner, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchBloc>(
      create:
          (context) =>
              BranchBloc()
                ..add(FetchBranchesAndCommits(owner: owner, repo: repo)),
      child: Scaffold(
        appBar: AppBar(title: Text('Details: $repo')),
        body: BlocBuilder<BranchBloc, BranchState>(
          builder: (context, state) {
            if (state is BranchLoading) {
              return pageLoader();
            } else if (state is BranchError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is BranchLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.branchCommits.length,
                  itemBuilder: (context, index) {
                    final branch = state.branchCommits[index];
                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          branch.branches.name ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children:
                            branch.commits.map((commit) {
                              return ListTile(
                                title: Text(commit.commit!.message ?? ""),
                                subtitle: Text(
                                  '${commit.commit!.author!.name} • ${DateFormat("dd-MM-yyyy").format(commit.commit!.author!.date!.toLocal())}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
