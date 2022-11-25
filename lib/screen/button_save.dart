import 'package:ecommerceapp/data/database/local_database.dart';
import 'package:ecommerceapp/utils/carts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart';

class ItemWidget extends StatefulWidget {
  VoidCallback ondeletd;
  Model product;
  ItemWidget({required this.product, required this.ondeletd, Key? key})
      : super(key: key);

  @override
  State<ItemWidget> createState() => _productItemWidgetState();
}

class _productItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool isHas = false;
        Model founded = Model(
            image: "image",
            id: 0,
            title: "title",
            description: "description",
            price: 1,
            category: "");
        for (Model i in cart_items) {
          if (widget.product.title == i.title) {
            print(widget.product.title);
            print(i.title);
            isHas = true;
            founded = i;
          }
        }
        if (isHas == false) {
          if (widget.product.count == 0) {
            widget.product.count += 1;
            await LocalDatabase.insertToDatabase(widget.product);
          }
        } else {
          await LocalDatabase.deleteTaskById(widget.product.id!.toInt());
          founded.count += 1;
          await LocalDatabase.insertToDatabase(founded);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text("${widget.product.title} savatga qo'shildi"),
          ),
        );
      },
      child: Container(
        height: 32,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Text(
            "Savatga qo'shish",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}