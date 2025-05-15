// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

List<BranchModel> branchModelFromJson(String str) => List<BranchModel>.from(
  json.decode(str).map((x) => BranchModel.fromJson(x)),
);

String branchModelToJson(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  String? name;
  Commit? commit;
  bool? protected;

  BranchModel({this.name, this.commit, this.protected});

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    name: json["name"],
    commit: json["commit"] == null ? null : Commit.fromJson(json["commit"]),
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "commit": commit?.toJson(),
    "protected": protected,
  };
}

class Commit {
  String? sha;
  String? url;

  Commit({this.sha, this.url});

  factory Commit.fromJson(Map<String, dynamic> json) =>
      Commit(sha: json["sha"], url: json["url"]);

  Map<String, dynamic> toJson() => {"sha": sha, "url": url};
}
