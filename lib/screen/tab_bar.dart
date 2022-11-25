
import 'package:ecommerceapp/data/model/category_model.dart';
import 'package:ecommerceapp/screen/electronic.dart';
import 'package:ecommerceapp/screen/home_page.dart';
import 'package:ecommerceapp/screen/jewelery.dart';
import 'package:ecommerceapp/screen/mens%20clothing.dart';
import 'package:ecommerceapp/screen/women%20s%20clothing.dart';
import 'package:flutter/material.dart';


class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        
        appBar: AppBar(
          
          title:const Text(
            'E-Commerce_APP',
          ),
          
          
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.deepPurple,


            indicatorColor: Colors.deepPurple,
            tabs: [
              const  Tab(
              icon: Text('All')
            ),
            Tab(
              icon: Text(Category.CategoryList[0])
            ),
            Tab(
              icon: Text(Category.CategoryList[1])
            ),
            Tab(
              icon: Text(Category.CategoryList[2])
            ),
            Tab(
              icon: Text(Category.CategoryList[3])
            ),
          ]),
        ),
        body:const TabBarView(children: [
          HomePage(),
          Electronic(),
          Jewelery(),
          Mens(),
          Womens_clothiz(),
        ]),
      ),
    );
  }
 

}
