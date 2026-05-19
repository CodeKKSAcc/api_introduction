class ReactionModel {
  int likes;
  int dislikes;

  ReactionModel({required this.likes, required this.dislikes});

  factory ReactionModel.fromJson(Map<String, dynamic> myJson) {
    return ReactionModel(likes: myJson["likes"], dislikes: myJson["dislikes"]);
  }
}

class PostModel {
  int id;
  String title;
  String body;
  List<dynamic> tags;
  ReactionModel reaction;
  int views;
  int userId;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reaction,
    required this.views,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> myJson) {
    return PostModel(
      id: myJson["id"],
      title: myJson["title"],
      body: myJson["body"],
      tags: myJson["tags"],
      reaction: ReactionModel.fromJson(myJson["reactions"]),
      views: myJson["views"],
      userId: myJson["userId"],
    );
  }
}

class DataModel {
  int limit;
  int skip;
  int total;
  List<PostModel> posts;

  DataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.posts,
  });

  factory DataModel.fromJson(Map<String, dynamic> myJson) {
    List<PostModel> allPost = [];

    for (Map<String, dynamic> json in myJson["posts"]) {
      allPost.add(PostModel.fromJson(json));
    }

    return DataModel(
      limit: myJson["limit"],
      skip: myJson["skip"],
      total: myJson["total"],
      posts: allPost,
    );
  }
}
