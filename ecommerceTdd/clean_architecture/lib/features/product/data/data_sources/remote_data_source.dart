import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
        await client.get(Uri.parse(Urls.getcurrentProductById(id)), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return ProductModel.fromJsn(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(Urls.getAllproducts()));

    if (response.statusCode == 200) {
      final jsonsss = json.decode(response.body);

      return List<ProductModel>.from(
          jsonsss['data'].map((model) => ProductModel.fromJsn(model)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> createProduct(ProductEntity product) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.createProduct()),
    );
    request.fields.addAll(
      {
        'name': product.name,
        'description': product.description,
        'price': '${product.price}',
      },
    );
    request.files.add(await http.MultipartFile.fromPath(
        'image', product.imageUrl,
        contentType: MediaType('image', 'jpeg')));

    var streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);
    print(response);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response.statusCode);
      final body = response.body;
      return ProductModel.fromJsn(json.decode(body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.deleteProduct(id)));

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductEntity product) async {
    final response = await client.put(Uri.parse(Urls.updateProduct(product)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price
        }));
    if (response.statusCode == 200) {
      return ProductModel.fromJsn(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}
