import 'dart:convert';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/product/data/models/product_model.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../Fixtures/dummy_data.reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testId = '2';
  const jsonFile = '/dummy_product_response.json';
  const jsonsFile = '/dummy_products.json';

  const testProduct = ProductEntity(
    description: 'des',
    id: '3',
    name: 'prod',
    imageUrl: '/Users/dell/Desktop/che.jpg',
    price: 10,
  );
  final testmodel =
      ProductModel.fromJsn(json.decode(readJson(jsonFile))['data']);
  const base = 'https://g5-flutter-learning-path-be.onrender.com/api/v1';

  group('get current product', () {
    test('''should perform a get method on a url with 
    given id and with application/json header''', () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(readJson(jsonFile), 200));

      //act

      productRemoteDataSourceImpl.getCurrentProduct(testId);

      //assert
      verify(mockHttpClient.get(Uri.parse('$base/products/$testId'), headers: {
        'Content-Type': 'application/json',
      }));
    });
    test('should return weather model when response is 200', () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(readJson(jsonFile), 200));

      //act

      final result =
          await productRemoteDataSourceImpl.getCurrentProduct(testId);
      //assert
      expect(result, equals(testmodel));
    });
    test(
        'should return a server exception when the status code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient
          .get(Uri.parse(Urls.getcurrentProductById(testId)), headers: {
        'Content-Type': 'application/json',
      })).thenAnswer((_) async => http.Response('Not Found', 404));

      //act

      //assert
      expect(() => productRemoteDataSourceImpl.getCurrentProduct(testId),
          throwsA(isA<ServerException>()));
    });
  });

  group('Get all products', () {
    test('should return all products when response is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getAllproducts())))
          .thenAnswer((_) async => http.Response(readJson(jsonsFile), 200));

      //act

      final result = await productRemoteDataSourceImpl.getAllProducts();

      //assert
      expect(result, isA<List<ProductModel>>());
    });

    test('should return a server exception when status code is wrong',
        () async {
      when(mockHttpClient.get(Uri.parse(Urls.getAllproducts())))
          .thenAnswer((_) async => http.Response('Not found', 404));

      //act

      //assert
      expect(() => productRemoteDataSourceImpl.getAllProducts(),
          throwsA(isA<ServerException>()));
    });
  });

  group('Create a product', () {
    test('should return the created product when status code is 201', () async {
      //arrange
      when(mockHttpClient.post(Uri.parse(Urls.createProduct())))
          .thenAnswer((_) async => http.Response(readJson(jsonFile), 201));

      //assert
      final result =
          await productRemoteDataSourceImpl.createProduct(testProduct);
      //act

      expect(result, isA<ProductModel>());
    });

    test('should return a server exception when the response is not not 201',
        () async {
      //arrange
      final response = http.Response('Could not create', 404);
      when(mockHttpClient.send(any))
          .thenAnswer((_) async => http.StreamedResponse(
                Stream.fromIterable([response.bodyBytes]),
                response.statusCode,
              ));
      //act

      expect(() => productRemoteDataSourceImpl.createProduct(testProduct),
          throwsA(isA<ServerException>()));
    });
  });

  group('delete a product', () {
    test('should delete a product and return null', () async {
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct(testId))))
          .thenAnswer((_) async => http.Response('no content', 200));

      await productRemoteDataSourceImpl.deleteProduct(testId);
    });

    test('should return a server exception when it can\'t delete a product',
        () async {
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct(testId))))
          .thenAnswer((_) async => http.Response('no content', 203));

      expect(() => productRemoteDataSourceImpl.deleteProduct(testId),
          throwsA(isA<ServerException>()));
    });
  });

  group('update a product', () {
    test('should return an updated product', () async {
      when(mockHttpClient
          .put(Uri.parse(Urls.updateProduct(testProduct)), headers: {
        'Content-Type': 'application/json',
      }, body: jsonEncode({
        'name': testProduct.name,
        'description': testProduct.description,
        'price': testProduct.price
      })
      )
      ).thenAnswer((_) async => http.Response(readJson(jsonFile), 200));

      final result =
          await productRemoteDataSourceImpl.updateProduct(testProduct);

      expect(result, isA<ProductModel>());
    });
    test('should throw a server exception', () async {
      when(mockHttpClient
          .put(Uri.parse(Urls.updateProduct(testProduct)), headers: {
        'Content-Type': 'application/json',
      }, body: jsonEncode({
        'name': testProduct.name,
        'description': testProduct.description,
        'price': testProduct.price
      }))).thenAnswer((_) async => http.Response(readJson(jsonFile), 400));

      expect(() => productRemoteDataSourceImpl.updateProduct(testProduct),
          throwsA(isA<ServerException>()));
    });
  });
}
