// To parse this JSON data, do
//
//     final commitsModel = commitsModelFromJson(jsonString);

import 'dart:convert';

List<CommitsModel> commitsModelFromJson(String str) => List<CommitsModel>.from(
  json.decode(str).map((x) => CommitsModel.fromJson(x)),
);

String commitsModelToJson(List<CommitsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommitsModel {
  String? sha;
  String? nodeId;
  Commit? commit;
  String? url;
  String? htmlUrl;
  String? commentsUrl;
  CommitsModelAuthor? author;
  CommitsModelAuthor? committer;
  List<Parent>? parents;

  CommitsModel({
    this.sha,
    this.nodeId,
    this.commit,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.author,
    this.committer,
    this.parents,
  });

  factory CommitsModel.fromJson(Map<String, dynamic> json) => CommitsModel(
    sha: json["sha"],
    nodeId: json["node_id"],
    commit: json["commit"] == null ? null : Commit.fromJson(json["commit"]),
    url: json["url"],
    htmlUrl: json["html_url"],
    commentsUrl: json["comments_url"],
    author:
        json["author"] == null
            ? null
            : CommitsModelAuthor.fromJson(json["author"]),
    committer:
        json["committer"] == null
            ? null
            : CommitsModelAuthor.fromJson(json["committer"]),
    parents:
        json["parents"] == null
            ? []
            : List<Parent>.from(
              json["parents"]!.map((x) => Parent.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "node_id": nodeId,
    "commit": commit?.toJson(),
    "url": url,
    "html_url": htmlUrl,
    "comments_url": commentsUrl,
    "author": author?.toJson(),
    "committer": committer?.toJson(),
    "parents":
        parents == null
            ? []
            : List<dynamic>.from(parents!.map((x) => x.toJson())),
  };
}

class CommitsModelAuthor {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  String? userViewType;
  bool? siteAdmin;

  CommitsModelAuthor({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.userViewType,
    this.siteAdmin,
  });

  factory CommitsModelAuthor.fromJson(Map<String, dynamic> json) =>
      CommitsModelAuthor(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        userViewType: json["user_view_type"],
        siteAdmin: json["site_admin"],
      );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "node_id": nodeId,
    "avatar_url": avatarUrl,
    "gravatar_id": gravatarId,
    "url": url,
    "html_url": htmlUrl,
    "followers_url": followersUrl,
    "following_url": followingUrl,
    "gists_url": gistsUrl,
    "starred_url": starredUrl,
    "subscriptions_url": subscriptionsUrl,
    "organizations_url": organizationsUrl,
    "repos_url": reposUrl,
    "events_url": eventsUrl,
    "received_events_url": receivedEventsUrl,
    "type": type,
    "user_view_type": userViewType,
    "site_admin": siteAdmin,
  };
}

class Commit {
  CommitAuthor? author;
  CommitAuthor? committer;
  String? message;
  Tree? tree;
  String? url;
  int? commentCount;
  Verification? verification;

  Commit({
    this.author,
    this.committer,
    this.message,
    this.tree,
    this.url,
    this.commentCount,
    this.verification,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    author:
        json["author"] == null ? null : CommitAuthor.fromJson(json["author"]),
    committer:
        json["committer"] == null
            ? null
            : CommitAuthor.fromJson(json["committer"]),
    message: json["message"],
    tree: json["tree"] == null ? null : Tree.fromJson(json["tree"]),
    url: json["url"],
    commentCount: json["comment_count"],
    verification:
        json["verification"] == null
            ? null
            : Verification.fromJson(json["verification"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author?.toJson(),
    "committer": committer?.toJson(),
    "message": message,
    "tree": tree?.toJson(),
    "url": url,
    "comment_count": commentCount,
    "verification": verification?.toJson(),
  };
}

class CommitAuthor {
  String? name;
  String? email;
  DateTime? date;

  CommitAuthor({this.name, this.email, this.date});

  factory CommitAuthor.fromJson(Map<String, dynamic> json) => CommitAuthor(
    name: json["name"],
    email: json["email"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "date": date?.toIso8601String(),
  };
}

class Tree {
  String? sha;
  String? url;

  Tree({this.sha, this.url});

  factory Tree.fromJson(Map<String, dynamic> json) =>
      Tree(sha: json["sha"], url: json["url"]);

  Map<String, dynamic> toJson() => {"sha": sha, "url": url};
}

class Verification {
  bool? verified;
  String? reason;
  dynamic signature;
  dynamic payload;
  dynamic verifiedAt;

  Verification({
    this.verified,
    this.reason,
    this.signature,
    this.payload,
    this.verifiedAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    verified: json["verified"],
    reason: json["reason"],
    signature: json["signature"],
    payload: json["payload"],
    verifiedAt: json["verified_at"],
  );

  Map<String, dynamic> toJson() => {
    "verified": verified,
    "reason": reason,
    "signature": signature,
    "payload": payload,
    "verified_at": verifiedAt,
  };
}

class Parent {
  String? sha;
  String? url;
  String? htmlUrl;

  Parent({this.sha, this.url, this.htmlUrl});

  factory Parent.fromJson(Map<String, dynamic> json) =>
      Parent(sha: json["sha"], url: json["url"], htmlUrl: json["html_url"]);

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "url": url,
    "html_url": htmlUrl,
  };
}
