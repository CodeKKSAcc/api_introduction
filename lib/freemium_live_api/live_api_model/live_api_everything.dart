class SourceModel {
  String? id;
  String name;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json["id"] ?? "No data available",
      name: json["name"] ?? "No data available",
    );
  }
}

class ArticlesModel {
  SourceModel source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  ArticlesModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      source: SourceModel.fromJson(json["source"] ?? {}),
      author: json["author"]?? "No data available",
      title: json["title"]?? "No data available",
      description: json["description"]?? "No data available",
      url: json["url"]??"https://oggyandthecockroaches.fandom.com/wiki/Oggy",
      urlToImage: json["urlToImage"]??"https://oggyandthecockroaches.fandom.com/wiki/Oggy",
      publishedAt: json["publishedAt"]?? "No data available",
      content: json["content"]?? "No data available",
    );
  }
}

class EveryNewsData {
  String status;
  int totalResults;
  List<ArticlesModel> articles;

  EveryNewsData({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory EveryNewsData.fromJson(Map<String, dynamic> json) {
    List<ArticlesModel> everyArticle = [];

    for (Map<String, dynamic> data in json["articles"]) {
      everyArticle.add(ArticlesModel.fromJson(data));
    }

    return EveryNewsData(
      status: json["status"]?? "No data available",
      totalResults: json["totalResults"]??0,
      articles: everyArticle,
    );
  }
}

// https://newsapi.org/v2/everything?q=bitcoin&apiKey=41b30b5c73b7415cb85e9a15d42bb6b7
