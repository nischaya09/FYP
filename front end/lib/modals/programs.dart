class ProgramsModel {
  final int id;
  final String name;
  final String image;

  ProgramsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProgramsModel.fromJson(Map<String, dynamic> json) {
    return ProgramsModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
}
