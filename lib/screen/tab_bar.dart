
import 'package:ecommerceapp/data/model/category_model.dart';
import 'package:ecommerceapp/screen/home_page.dart';
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
          
          title: Text(
            'username',
          ),
          
          
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
            Tab(
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
        body: TabBarView(children: [
          HomePage(),
          Container(),
          Container(),
          Container(),
          Container(),
        ]),
      ),
    );
  }
 

}
