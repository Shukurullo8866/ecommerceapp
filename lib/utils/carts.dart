// ignore_for_file: non_constant_identifier_names

import '../data/database.dart/local_database.dart';
import '../data/model/product_model.dart';

List<Model> cart_items = [];
getCartItem() async {
  cart_items = await LocalDatabase.getList();
}