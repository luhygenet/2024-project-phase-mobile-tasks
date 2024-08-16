import 'dart:ffi';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.productLocalDataSource,
      required this.networkInfo,
      required this.productRemoteDataSource});

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
      ProductEntity product) async {
    try {
      final result = await productRemoteDataSource.createProduct(product);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('error in creating due to server failure'));
    } on SocketException {
      return const Left(
          ServerFailure('error in creating due to internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await productRemoteDataSource.deleteProduct(id);
      return Right(Void);
    } on ServerException {
      return const Left(ServerFailure('error in deleting due to server'));
    } on SocketException {
      return const Left(SocketFailure('socket Failure'));
    } on NotFoundException catch (e) {
      print(e.message);
      print("ezi");
      return Left(NotFoundFailure('not found'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getAllProducts();
        final resultEntities = result.map((model) => model.toEntity()).toList();
        return Right(resultEntities);
      } on ServerException {
        return const Left(ServerFailure('error in deleting due to server'));
      } on SocketException {
        return const Left(SocketFailure('socket Failure'));
      }
    } else {
      try {
        final localTrivia = await productLocalDataSource.getAllLastProduct();
        final localTrivias =
            localTrivia.map((model) => model.toEntity()).toList();
        return Right(localTrivias);
      } on CacheException {
        return Left(CacheFailure('no cache found'));
      } on ServerException {
        return const Left(ServerFailure('server error occurred'));
      } on SocketException {
        return const Left(SocketFailure('socket failure'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getCurrentProduct(String id) async {
    networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getCurrentProduct(id);
        productLocalDataSource.cacheAllProduct(result);
        print('exi');
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure('an error with the server'));
      } on SocketException {
        return const Left(SocketFailure('an error with the socket'));
      }
    } else {
      try {
        final localTrivia = await productLocalDataSource.getAllLastProduct();
        final localTrivias =
            localTrivia.map((model) => model.toEntity()).toList();
        return Right(localTrivias[1]);
      } on CacheException {
        return Left(CacheFailure('no cache found'));
      } on ServerException {
        return const Left(ServerFailure('server error occurred'));
      } on SocketException {
        return const Left(SocketFailure('socket failure'));
      }
    }
  }
  
  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    try {
      final result = await productRemoteDataSource.updateProduct(product);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('an error with the server'));
    } on SocketException {
      return const Left(SocketFailure('an error with the socket'));
    }
  }
}
