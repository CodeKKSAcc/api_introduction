class UserModel {
  int id;
  String username;
  String fullName;

  UserModel({required this.id, required this.username, required this.fullName});

  factory UserModel.fromJson(Map<String, dynamic> myJson) {
    return UserModel(
      id: myJson["id"],
      username: myJson["username"],
      fullName: myJson["fullName"],
    );
  }
}

class CommentModel {
  int id;
  int likes;
  int postId;
  String body;
  UserModel user;

  CommentModel({
    required this.id,
    required this.likes,
    required this.postId,
    required this.body,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> myJson) {
    return CommentModel(
      id: myJson["id"],
      likes: myJson["likes"],
      postId: myJson["postId"],
      body: myJson["body"],
      user: UserModel.fromJson(myJson["user"]),
    );
  }
}

class DataModel {
  int limit;
  int skip;
  int total;
  List<CommentModel> comments;

  DataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.comments,
  });

  factory DataModel.fromJson(Map<String, dynamic> myJson){

    List<CommentModel> myComment = [];

    for(Map<String, dynamic> eachComment in myJson["comments"]){
      myComment.add(CommentModel.fromJson(eachComment));
    }

    return DataModel(limit: myJson["limit"],
        skip: myJson["skip"],
        total: myJson["total"],
        comments: myJson["comments"]);
  }
}
