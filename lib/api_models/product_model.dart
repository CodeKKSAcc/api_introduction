class MetaModel {
  String createdAt;
  String updatedAt;
  String barcode;
  String qrCode;

  MetaModel({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: json["createdAt"]?? "No Data available",
      updatedAt: json["updatedAt"]?? "No Data available",
      barcode: json["barcode"]?? "https://www.vecteezy.com/vector-art/67414546-barcode-icon-bar-code-symbol-illustration",
      qrCode: json["qrCode"]?? "https://en.wikipedia.org/wiki/QR_code",
    );
  }
}

class ReviewModel {
  int rating;
  String comment;
  String date;
  String reviewerName;
  String reviewerEmail;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json["rating"]??0,
      comment: json["comment"]?? "No Data available",
      date: json["date"]?? "No Data available",
      reviewerName: json["reviewerName"]?? "No Data available",
      reviewerEmail: json["reviewerEmail"]?? "No Data available",
    );
  }
}

class DimensionModel {
  num width;
  num height;
  num depth;

  DimensionModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory DimensionModel.fromJson(Map<String, dynamic> json) {
    return DimensionModel(
      width: json["width"]??0,
      height: json["height"]??0,
      depth: json["depth"]??0,
    );
  }
}

class ProductModel {
  int id;
  String title;
  String description;
  String category;
  num price;
  num discountPercentage;
  num rating;
  int stock;
  List<dynamic> tags;
  String brand;
  String sku;
  num weight;
  DimensionModel dimensions;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  List<ReviewModel> reviews;
  String returnPolicy;
  int minimumOrderQuantity;
  MetaModel meta;
  List<dynamic> images;
  String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {

    List<ReviewModel> allReviews = [];

    for(Map<String, dynamic> myJson in json["reviews"]){
      allReviews.add(ReviewModel.fromJson(myJson));
    }

    List<dynamic> allTags = [];

    for(dynamic data in json["tags"]){
      allTags.add(data);
    }

    List<dynamic> allImages = [];

    for(dynamic data in json["images"]){
      allImages.add(data);
    }

    return ProductModel(
      id: json["id"]??0,
      title: json["title"]?? "No Data available",
      description: json["description"]?? "No Data available",
      category: json["category"]?? "No Data available",
      price: json["price"]??0,
      discountPercentage: json["discountPercentage"]??0,
      rating: json["rating"]??0,
      stock: json["stock"]??0,
      tags: allTags,
      brand: json["brand"]?? "No Data available",
      sku: json["sku"]?? "No Data available",
      weight: json["weight"]??0,
      dimensions: DimensionModel.fromJson(json["dimensions"]??{}),
      warrantyInformation: json["warrantyInformation"]?? "No Data available",
      shippingInformation: json["shippingInformation"]?? "No Data available",
      availabilityStatus: json["availabilityStatus"]?? "No Data available",
      reviews: allReviews,
      returnPolicy: json["returnPolicy"]?? "No Data available",
      minimumOrderQuantity: json["minimumOrderQuantity"]??0,
      meta: MetaModel.fromJson(json["meta"] ?? {}),
      images: allImages,
      thumbnail: json["thumbnail"]?? "https://depositphotos.com/vectors/no-image-available.html",
    );
  }
}

class AllProductDataModel{

  int total;
  int skip;
  int limit;
  List<ProductModel> products;

  AllProductDataModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.products,
  });

  factory AllProductDataModel.fromJson(Map<String, dynamic> json) {

    List<ProductModel> allProduct = [];

    for(Map<String, dynamic> myJson in json["products"]){
      allProduct.add(ProductModel.fromJson(myJson));
    }

    return AllProductDataModel(
      total: json["total"]??0,
      skip: json["skip"]??0,
      limit: json["limit"]??0,
      products: allProduct,
    );
  }
}
