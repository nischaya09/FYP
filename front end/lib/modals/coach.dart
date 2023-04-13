class CoachModal {
  final int id;
  final String name;
  final String email;
  final String image;
  final String phone;

  CoachModal(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.phone});

  factory CoachModal.fromJson(Map<String, dynamic> json) {
    return CoachModal(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      image: json["image"],
      phone: json["phone"],
    );
  }
}
