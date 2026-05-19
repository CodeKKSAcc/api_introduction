class ApiProductModel {
  int id;
  String title;
  num price;
  int quantity;
  num total;
  num discountPercentage;
  num discountedTotal;
  String thumbnail;

  ApiProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) {
    return ApiProductModel(
      id: json["id"]??0,
      title: json["title"]?? "no i/p",
      price: json["price"]??0,
      quantity: json["quantity"]??0,
      total: json["total"]??0,
      discountPercentage: json["discountPercentage"]??0,
      discountedTotal: json["discountedTotal"]??0,
      thumbnail: json["thumbnail"] ??"https://oggyandthecockroaches.fandom.com/wiki/Oggy",
    );
  }
}

class CartModel {

  int id;
  List<ApiProductModel> products;
  num total;
  num discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  CartModel({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity
  });

  factory CartModel.fromJson(Map<String, dynamic> json){
    List<ApiProductModel> allProduct = [];

    for (Map<String, dynamic> eachJson in json["products"]) {
      allProduct.add(ApiProductModel.fromJson(eachJson));
    }

    return CartModel(
        id: json["id"]??0,
        products: allProduct?? [],
        total: json["total"]??0,
        discountedTotal: json["discountedTotal"]??0,
        userId: json["userId"]??0,
        totalProducts: json["totalProducts"]??0,
        totalQuantity: json["totalQuantity"]??0
    );
  }
}

class AllCartModel {

  int total;
  int skip;
  int limit;
  List<CartModel> carts;

  AllCartModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.carts
  });

  factory AllCartModel.fromJson(Map<String, dynamic> json){
    List<CartModel> allCart = [];

    for (Map<String, dynamic> myJson in json["carts"]) {
      allCart.add(CartModel.fromJson(myJson));
    }

    return AllCartModel(total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
        carts: allCart);
  }
}
