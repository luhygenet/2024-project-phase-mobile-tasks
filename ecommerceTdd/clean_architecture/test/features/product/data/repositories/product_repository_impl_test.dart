import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/product_model.dart';
import 'package:clean_architecture/features/product/data/repositories/product_repository_impl.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late ProductRepositoryImpl productRepositoryImpl;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        productRemoteDataSource: mockProductRemoteDataSource);
  });

  final testProductmodel = ProductModel(
      id: '1',
      name: 'modelproduct',
      description: 'niceproduct',
      imageUrl: 'imageUrl',
      price: '10');

  final testProductEntity = const ProductEntity(
      id: '1',
      name: 'modelproduct',
      description: 'niceproduct',
      imageUrl: 'imageUrl',
      price: '10');

  const testId = '2';

  group('get current product', () {
    test('returns current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenAnswer((_) async => testProductmodel);

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      expect(result, equals(Right(testProductEntity)));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });

  group('delete a product', () {
    test('should delete a product when successfull access to api', () async {
      when(mockProductRemoteDataSource.deleteProduct(testId))
          .thenAnswer((_) async => null);

      //act
      await productRepositoryImpl.deleteProduct(testId);

      //assert
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.deleteProduct(testId))
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.deleteProduct(testId);

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.deleteProduct(testId))
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.deleteProduct(testId);

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });

  group('Create a new product', () {
    test('returns current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.createProduct(testProductEntity))
          .thenAnswer((_) async => testProductmodel);

      //act
      final result =
          await productRepositoryImpl.createProduct(testProductEntity);

      //assert
      print(result.runtimeType);
      print(Right(testProductEntity).runtimeType);
      expect(result, equals(Right(testProductEntity)));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });

  final testReturnProducts = [
    ProductModel(
        id: '2',
        name: 'first product',
        description: 'this is my first product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
    ProductModel(
      id: '3',
      name: 'second product',
      description: 'this is my second product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '7',
    ),
    ProductModel(
        id: '4',
        name: 'third product',
        description: 'this is my third product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
  ];

  const testReturnEntities = [
    ProductEntity(
        id: '2',
        name: 'first product',
        description: 'this is my first product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
    ProductEntity(
      id: '3',
      name: 'second product',
      description: 'this is my second product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '7',
    ),
    ProductEntity(
        id: '4',
        name: 'third product',
        description: 'this is my third product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
  ];

  group('get all products', () {
    test('returns current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => testReturnProducts);

      //act
      final result = await productRepositoryImpl.getAllProducts();
      final unpacked =
          result.fold((failure) => null, (productList) => productList);
      //assert
      expect(unpacked, equals(testReturnEntities));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.getAllProducts())
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.getAllProducts();

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.getAllProducts())
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.getAllProducts();

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });

  group('update current product', () {
    test('updates current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.updateProduct(testProductEntity))
          .thenAnswer((_) async => testProductmodel);

      //act
      final result = await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(result, equals(Right(testProductEntity)));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.updateProduct(testProductEntity))
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.updateProduct(testProductEntity))
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });
}
