import 'package:flutter/material.dart';
import 'package:market/screens/tabs/categories_screen.dart';
import 'package:market/screens/tabs/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../view_models/tab_view_model.dart';
import 'products/products_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [
    ProductScreen(),
    Categories(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF07AF45),
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: "Products",
            activeIcon: Icon(
              Icons.check_box_outline_blank,
              color: Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
            activeIcon: Icon(
              Icons.category_sharp,
              color: Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            activeIcon: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
          )
        ],
      ),
    );
  }
}
