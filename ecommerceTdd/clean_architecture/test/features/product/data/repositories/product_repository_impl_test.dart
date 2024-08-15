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
  late ProductRepositoryImpl productRepositoryImpl;

  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  // late mockLocakDataSource;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockProductLocalDataSource = MockProductLocalDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        productRemoteDataSource: mockProductRemoteDataSource,
        productLocalDataSource: mockProductLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  final testProductmodel = ProductModel(
      id: '1',
      name: 'modelproduct',
      description: 'niceproduct',
      imageUrl: 'imageUrl',
      price: 10);

  //final ProductEntity tProduct = testProductmodel;

  const testProductEntity =  ProductEntity(
      id: '1',
      name: 'modelproduct',
      description: 'niceproduct',
      imageUrl: 'imageUrl',
      price: 10);

  const testId = '2';
  void runTestOnline(Function body) {
    group('get current product when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('get current product when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group( 'group', () => runTestOnline(() {
    test('returns current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenAnswer((_) async => testProductmodel);

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verify(mockProductRemoteDataSource.getCurrentProduct(testId));
      expect(result, equals(Right(testProductEntity)));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verify(mockProductRemoteDataSource.getCurrentProduct(testId));
      verifyZeroInteractions(mockProductLocalDataSource);
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

    test(
        'should cache the data locally when the call to the remote data source is successful',
        () async {
      //arrange
      print('ezi');
      when(mockProductRemoteDataSource.getCurrentProduct(testId))
          .thenAnswer((_) async => testProductmodel);

      //act
      await productRepositoryImpl.getCurrentProduct(testId);

      //assert

      verify(mockProductRemoteDataSource.getCurrentProduct(testId));
      verify(mockProductLocalDataSource.cacheProduct(testProductmodel));
    });
  })
);
  runTestOffline(() {
    test('should return last locally cached data if it is present', () async {
      //arrange
      when(mockProductLocalDataSource.getLastProduct())
          .thenAnswer((_) async => testProductmodel);

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verifyZeroInteractions(mockProductRemoteDataSource);
      verify(mockProductLocalDataSource.getLastProduct());
      expect(result, equals(Right(testProductEntity)));
    });

    test('should return cache failure if no cached data is present', () async {
      //arrange
      when(mockProductLocalDataSource.getLastProduct())
          .thenThrow(CacheException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verifyZeroInteractions(mockProductRemoteDataSource);
      verify(mockProductLocalDataSource.getLastProduct());
      expect(result, equals(Left(CacheFailure('no cache was found'))));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductLocalDataSource.getLastProduct())
          .thenThrow(ServerException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verify(mockProductLocalDataSource.getLastProduct());
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductLocalDataSource.getLastProduct())
          .thenThrow(SocketException());

      //act
      final result = await productRepositoryImpl.getCurrentProduct(testId);

      //assert
      verify(mockProductLocalDataSource.getLastProduct());
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });

  runTestOnline(() {
    test('returns current data when call to api is successful', () async {
      //arrange
      when(mockProductRemoteDataSource.createProduct(testProductEntity))
          .thenAnswer((_) async => testProductmodel);

      //act
      final result =
          await productRepositoryImpl.createProduct(testProductEntity);

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

  runTestOnline(() {
    final testReturnProducts = [
      ProductModel(
          id: '2',
          name: 'first product',
          description: 'this is my first product',
          imageUrl: 'assets/shoe2.jpeg',
          price: 6),
      ProductModel(
        id: '3',
        name: 'second product',
        description: 'this is my second product',
        imageUrl: 'assets/shoe2.jpeg',
        price: 7,
      ),
      ProductModel(
          id: '4',
          name: 'third product',
          description: 'this is my third product',
          imageUrl: 'assets/shoe2.jpeg',
          price: 6),
    ];

    const testReturnEntities = [
      ProductEntity(
          id: '2',
          name: 'first product',
          description: 'this is my first product',
          imageUrl: 'assets/shoe2.jpeg',
          price: 6),
      ProductEntity(
        id: '3',
        name: 'second product',
        description: 'this is my second product',
        imageUrl: 'assets/shoe2.jpeg',
        price: 7,
      ),
      ProductEntity(
          id: '4',
          name: 'third product',
          description: 'this is my third product',
          imageUrl: 'assets/shoe2.jpeg',
          price: 6),
    ];
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
      final result =
          await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(result, equals(Right(testProductEntity)));
    });

    test('returns server error when the call to api is unsuccessful', () async {
      //arrange
      when(mockProductRemoteDataSource.updateProduct(testProductEntity))
          .thenThrow(ServerException());

      //act
      final result =
          await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test('returns connection error when there\'s no internet', () async {
      //arrange
      when(mockProductRemoteDataSource.updateProduct(testProductEntity))
          .thenThrow(SocketException());

      //act
      final result =
          await productRepositoryImpl.updateProduct(testProductEntity);

      //assert

      expect(
          result, equals(const Left(SocketFailure('no internet connection'))));
    });
  });
}
