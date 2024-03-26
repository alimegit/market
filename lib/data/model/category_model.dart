class CategoryModel {
  final String name;
  final String docId;
  final String imageUrl;

  CategoryModel({
    required this.name,
    required this.imageUrl,
    required this.docId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic>json){
    return CategoryModel(
        name: json["name"] as String? ?? "",
        docId: json["docId"] as String? ?? "",
        imageUrl: json["imageUrl"] as String? ?? "Rasm xato",
    );
  }

  Map<String, dynamic> toJson() {
    return {

      "doc_id": "",
      "category_name": name,
      "image_url": imageUrl,
    };
  }
  Map<String, dynamic> toJsonForUpdate() {
    return {
      "category_name": name,
      "image_url": imageUrl,
    };
  }
}