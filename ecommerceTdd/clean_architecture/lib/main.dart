import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './features/product/presentation/screens/Search.dart';
import 'features/product/presentation/screens/Add.dart';
import './features/product/presentation/screens/details.dart';
import './features/product/presentation/screens/home_page.dart';

import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/screens/Update.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  di.sl<http.Client>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBloc(
            viewProductUsecase: sl(),
            viewAllProductsUseCase: sl(),
            updateProductUseCase: sl(),
            createProductUseCase: sl(),
            deleteProductUseCase: sl()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/details': (context) => const ProductDetailsPage(),
            '/add': (context) => const Add(),
            '/search': (context) => const Search(),
            '/update': (context) => const Update(),
          },
        ));
  }
}
