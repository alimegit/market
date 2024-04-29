class SenNotifModel {
  final String body;
  final String title;


  SenNotifModel({
    required this.body,
    required this.title,

  });

  factory SenNotifModel.fromJson(Map<String, dynamic> json) {
    return SenNotifModel(
      body: json["body"] as String? ?? "",
      title: json["title"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "body": body,
      "title": title,
    };
  }
}