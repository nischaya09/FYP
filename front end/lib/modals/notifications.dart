class NotificationModal {
  final String title;

  NotificationModal({
    required this.title,
  });

  factory NotificationModal.fromJson(Map<String, dynamic> json) {
    return NotificationModal(
      title: json["message"],
    );
  }
}
