import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllLastProduct();

  Future<void> cacheAllProduct(ProductModel productToCache);
}

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getAllLastProduct() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS);
    if (jsonString != null) {
      print(jsonString);
      List<dynamic> jsonList = json.decode(jsonString);
      List<ProductModel> products = jsonList
          .map((json) => ProductModel.fromJsn(json as Map<String, dynamic>))
          .toList();
      return Future.value(products);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAllProduct(ProductModel productToCache) {
    return sharedPreferences.setString(
        CACHED_PRODUCTS, json.encode(productToCache.tojsn()));
  }
}
