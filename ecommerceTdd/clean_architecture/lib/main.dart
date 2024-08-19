import 'package:flutter/material.dart';

import './features/product/presentation/screens/Search.dart';
import './features/product/presentation/screens/Update.dart';
import './features/product/presentation/screens/details.dart';
import './features/product/presentation/screens/home_page.dart';

import 'injection_container.dart' as di;

void main() async {
  await di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const ProductDetailsPage(),
        '/update': (context) => const Update(),
        '/search': (context) => const Search()
      },
    );
  }
}
