class ProductsModel {
  final int id;
  final String name;
  final String image;

  ProductsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
}
