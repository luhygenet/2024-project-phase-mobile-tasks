import 'dart:ffi';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});

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
      return const Right(Void);
    } on ServerException {
      return const Left(ServerFailure('error in deleting due to server'));
    } on SocketException {
      return const Left(SocketFailure('socket Failure'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final result = await productRemoteDataSource.getAllProducts();
      final resultEntities = result.map((model) => model.toEntity()).toList();
      return Right(resultEntities);
    } on ServerException {
      return const Left(ServerFailure('error in deleting due to server'));
    } on SocketException {
      return const Left(SocketFailure('socket Failure'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getCurrentProduct(String id) async {
    try {
      final result = await productRemoteDataSource.getCurrentProduct(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('an error with the server'));
    } on SocketException {
      return const Left(SocketFailure('an error with the socket'));
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
