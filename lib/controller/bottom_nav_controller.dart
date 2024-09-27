import 'package:flutter/material.dart';
import 'package:news_app_api/view/Screens/home_screen/home_screeen.dart';
import 'package:news_app_api/view/Screens/search_screen/search_screen.dart';
import '../view/Screens/category_screen/category_screen.dart';

class BottomNavController with ChangeNotifier {
  int selectedIndex = 0;

  void onItemTap(index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<Widget> mypages = [HomeScreeen(), CategoryScreen(), SearchScreen()];
}