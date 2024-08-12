
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getCurrentProduct(String id);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String id);
}
