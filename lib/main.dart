import 'package:flutter/material.dart';
import 'package:news_app_api/controller/bottom_nav_controller.dart';
import 'package:news_app_api/controller/category_controller.dart';
import 'package:news_app_api/view/Screens/bottom_nav/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'controller/home_screen_controller.dart';

void main() {
  runApp(NewsToday());
}
class NewsToday extends StatelessWidget {
  const NewsToday({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>HomeScreenController(),
        ),
        ChangeNotifierProvider(create: (context)=>CategoryController(),
        ),
        ChangeNotifierProvider(create: (context)=>SearchController(),
        ),
        ChangeNotifierProvider(create: (context)=>BottomNavController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Today',
        home: BottomNavScreen(),
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[175])
        ),
      ),
    );
  }
}