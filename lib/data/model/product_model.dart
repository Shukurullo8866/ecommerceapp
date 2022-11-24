import 'dart:convert';

class Model {
  num? id;
  String? title;
  int count = 0;
  num? price;
  String? description;
  String? category;
  String? image;
  int? databaseid;

  Model({
    this.databaseid,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.count = 0,
  });

  factory Model.fromJson(Map<String, dynamic> jsonData) {
    num id = jsonData['id'] ?? 0;
    String title = jsonData['title'] ?? '';

    num price = jsonData['price'] ?? 0.0;
    String description = jsonData['description'] ?? '';
    String category = jsonData['category'] ?? '';
    String image = jsonData['image'] ?? '';

    return Model(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "count": count,
        "price": price,
        "category": category,
        "image": image,
        "description": description,
      };

  Model copyWith({
    num? id,
    String? title,
    num? price,
    String? category,
    String? description,
    String? image,
    int? databaseid,
    int? count,
  }) =>
      Model(
        id: id ?? this.id,
        title: title ?? this.title,
        price: this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        databaseid: databaseid ?? this.databaseid,
      );
}
