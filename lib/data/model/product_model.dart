import 'dart:convert';

class Model {
  num? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;


  Model({required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        });

  factory Model.fromJson(Map<String,dynamic> jsonData){
    num id = jsonData['id']?? 0;
    String title = jsonData['title']?? '';
    num price = jsonData['price']?? 0.0;
    String description = jsonData['description']?? '';
    String category = jsonData['category']?? '';
    String image = jsonData['image']?? '';
    
    return Model(id: id, title: title, price: price, description: description, category: category, image: image);
  }
}