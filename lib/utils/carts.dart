import 'package:ecommerceapp/data/database/local_database.dart';

import '../data/model/product_model.dart';

List<Model> cart_items = [];
getCartItem() async {
  cart_items = await LocalDatabase.getList();
}