import 'package:eventique_shreek/pages/navigation_bar_page.dart';
import 'package:eventique_shreek/providers/orders.dart';
import 'package:eventique_shreek/providers/reviews.dart';
import 'package:eventique_shreek/providers/services_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String host = 'http://192.168.1.102:8000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AllServices(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Reviews(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigationBarPage(),
      ),
    );
  }
}