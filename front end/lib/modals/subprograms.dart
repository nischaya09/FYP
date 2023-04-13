class SubProgramsModel {
  final int id;
  final String name;
  final String image;

  SubProgramsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SubProgramsModel.fromJson(Map<String, dynamic> json) {
    return SubProgramsModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
}
