import 'dart:convert';

import 'package:ecommerceapp/item_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'data/model/product_model.dart';

class SecondPage extends StatefulWidget {

  SecondPage({super.key, });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
   Future<List<Model>?>? getResult;


  Future<List<Model>> getData() async {
    String url = "https://fakestoreapi.com/products";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body) as List;
      List<Model> users = json.map((e) => Model.fromJson(e)).toList();

      return users;
    }
    return List.empty();
  }

  @override
  void initState() {
    super.initState();

    getResult = getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Kategoriyalar ro'yxati",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: getResult,
           builder: (BuildContext context,
                  AsyncSnapshot<List<Model>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              List<Model?>? data = snapshot.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 0.1),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 130,
                              width: 130,
                              child: Image.network(
                                data[index]!.image.toString(),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              data[index]!.category.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "USD ${data[index]!.price.toString()}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 9, 96, 166),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ItemWidget(
                              product: data[index]!,
                              ondeletd: () {
                                setState(
                                  () {},
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
  }