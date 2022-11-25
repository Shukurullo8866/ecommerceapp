import 'package:ecommerceapp/screen/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabBArViewPage extends StatefulWidget {
   TabBArViewPage({super.key});

  @override
  State<TabBArViewPage> createState() => _TabBArViewPageState();
}

class _TabBArViewPageState extends State<TabBArViewPage> {
  int Index = 0;

   List<Widget> _page = [
   
    TabBarPage(),
    Container(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[Index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        onTap: (int index){
          setState(() {
            Index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: Index,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,),
          label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_rounded, size: 30,),
          label: ''),
        ]
      ),
    );
  }
}