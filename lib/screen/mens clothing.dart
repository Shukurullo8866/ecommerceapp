
import 'dart:convert';
import 'package:ecommerceapp/data/model/category_model.dart';
import 'package:ecommerceapp/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Mens extends StatefulWidget {
  const Mens({super.key});

  @override
  State<Mens> createState() => _MensState();
}

class _MensState extends State<Mens> {
  Future<List<Model>?>? getResult;


  Future<List<Model>> getData() async {
    String url = "https://fakestoreapi.com/products/category/${Category.CategoryList[2]}";

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
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: Container(
        child: FutureBuilder<List<Model>?>(
              future: getResult,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Model>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  List<Model?>? users = snapshot.data;
                  print(snapshot.data![0].category);
                  
                  return Container(
                  
                    child: GridView.builder(
                      
                      scrollDirection: Axis.vertical,
                      
                      shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: users!.length,
                        itemBuilder: (context, index) {
                       
                         return stuff(
                              context,
                          
                              users[index]?.id ?? 0,
                              users[index]?.title ?? "NO",
                              users[index]?.price ?? 0.0,
                              users[index]?.description ?? "NO",
                              users[index]?.category ?? "NO",
                              users[index]?.image ?? "NO"
                              );

                          
                        }),
                           
                  );
                  
                }
                return Container(
                color: Colors.red,
                );
              }),
      ));
    
  }

  stuff(context,id,title,price,description,category,image){
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
              color: Colors.grey,
              offset: Offset(1,1),
              blurRadius: 2,
              spreadRadius: 2
            )],
            borderRadius: BorderRadius.circular(15)
          ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(height: 10,),
        Container(
          height: 100,
          width: 100,
          
          
          child: Image.network(image,width: 220,) ,
        ),
        SizedBox(height:height1*0.01),
        Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(title,maxLines: 1,style: TextStyle(fontWeight: FontWeight.w700),)
          ),
        ),
        SizedBox(height:height1*0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child: Text(category,maxLines: 1,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                child: Text("\$ $price",maxLines: 1,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),)
              ),
            ),
          ],
        ),
       ]),
      ),
    );
}
}