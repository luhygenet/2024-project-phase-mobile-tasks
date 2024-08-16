import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/product/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../Fixtures/dummy_data.reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getAllLastproduct', () {
    List<dynamic> lists = json.decode(readJson('product_cached.json'));

    final expectedProductModels =
        lists.map((model) => ProductModel.fromJsn(model)).toList();

    test('should return last cached productS when there are some in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(readJson('product_cached.json'));

      //act
      final result = await dataSource.getAllLastProduct();

      //assert
      verify(mockSharedPreferences.getString(CACHED_PRODUCTS));
      expect(result, expectedProductModels);
    });

    test('should throe a cache exception when there are no cached products',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = dataSource.getAllLastProduct;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('CacheAllLastproduct', () {
    final toCacheProduct = ProductModel(
        id: '1',
        name: 'name',
        description: 'description',
        imageUrl: 'imageUrl',
        price: 17);
    //act
    test('should call shared preferences to cache the data', () {
       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
      //act
      dataSource.cacheAllProduct(toCacheProduct);
      //assert

      final expectedJson = json.encode(toCacheProduct.tojsn());
      verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson));
    });
  });
}
