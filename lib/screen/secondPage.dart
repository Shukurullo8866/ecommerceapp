import 'dart:convert';

import 'package:ecommerceapp/data/model/product_model.dart';
import 'package:ecommerceapp/screen/widgets/button_save.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class SecondPage extends StatefulWidget {
  var id1;
  SecondPage({super.key,required this.id1 });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
   Future<List<Model>?>? getResult;


  Future<List<Model>> getData() async {
    String url = "https://fakestoreapi.com/products/";

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
        title:  Text(
          "",
          
        ),
      ),
      body: 
         FutureBuilder(
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
              List<Model?>? users = snapshot.data;

              return stuff(
                                  context,
                                  users?[widget.id1],
                                  users?[widget.id1]?.id ?? 0,
                                  users?[widget.id1]?.title ?? "NO",
                                  users?[widget.id1]?.price ?? 0.0,
                                  users?[widget.id1]?.description ?? "NO",
                                  users?[widget.id1]?.category ?? "NO",
                                  users?[widget.id1]?.image ?? "NO"
                                  );
    }
    return Container();
    }
    

    ));
  }

  }
  stuff(context,users,id,title,price,description,category,image){
    var height1 = MediaQuery.of(context).size.height*0.5;
    var width1 = MediaQuery.of(context).size.width;
    
    return Container(
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
       SizedBox(height: 10,),
       Container(
         height: 350,
         width: 350,
         
         
         child: Image.network(image,width: 350,) ,
       ),
       SizedBox(height:height1*0.02),
       Container(
         padding: EdgeInsets.only(left: 10),
         alignment: Alignment.centerLeft,
         child: Text(title,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)
       ),
       SizedBox(height:height1*0.01),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Container(
           child: Text(description,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),)
         ),
       ),
       SizedBox(height:height1*0.04),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Container(
               child: Text("\$ $price",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue,fontSize: 30),)
             ),
           ),
           Container(
                  padding: EdgeInsets.only(right: 10),         child: ItemWidget(
                             product: users!,
                             ondeletd: () {
                               
                             },
                           ),
                         ),
         ],
       ),
       
      ]),
    );
}


