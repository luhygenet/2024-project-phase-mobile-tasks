import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class CreateProductUseCase extends BaseUsecase<ProductEntity, ProductEntity> {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await productRepository.createProduct(product);
  }
}
