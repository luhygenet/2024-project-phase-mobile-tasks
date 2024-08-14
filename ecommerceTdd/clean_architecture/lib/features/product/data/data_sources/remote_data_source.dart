import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getCurrentProduct(String id);
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> createProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> updateProduct(ProductEntity product);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getCurrentProduct(String id) async {
    final response =
        await client.get(Uri.parse(Urls.getcurrentProductById(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJsn(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(Urls.getAllproducts()));
    if (response.statusCode == 200) {
      return List<ProductModel>.from(json
          .decode(response.body)
          .map((model) => ProductModel.fromJsn(model)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> createProduct(ProductEntity product) async {
    final response = await client.post(
      Uri.parse(Urls.createProduct()),
    );
    if (response.statusCode == 201) {
      print(response.body);

      return ProductModel.fromJsn(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.deleteProduct(id)));
    if (response.statusCode == 204) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductEntity product) async {
    final response = await client.put(Uri.parse(Urls.updateProduct(product)));
    if (response.statusCode == 200) {
      return ProductModel.fromJsn(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
