import 'dart:convert';
import 'package:clean_architecture/features/product/data/models/product_model.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../Fixtures/dummy_data.reader.dart';

void main() {
  final testproductModel = ProductModel(
      id: '1',
      name: 'modelproduct',
      description: 'niceproduct',
      imageUrl: 'imageUrl',
      price: 10);

  test('should be a subclass of product model', () async {
    expect(testproductModel, isA<ProductEntity>());
  });

  test('should return a valid model json', () async {
    //arrange

    final Map<String, dynamic> jsonData=
        json.decode(readJson('dummy_product_response.json'));

    //act

    final result = ProductModel.fromJsn(jsonData['data']);

    //assert

    expect(result, testproductModel);
  });

  test('should return a JSON map with proper data', () async {
    //arrange 

    final expectedJson = {
      'id': '1',
      'name': 'modelproduct',
      'description': 'niceproduct',
      'imageUrl': 'imageUrl',
      'price': 10
    };

    //act
    final result = testproductModel.tojsn();

    //assert

    expect(result, expectedJson);
  });
}
