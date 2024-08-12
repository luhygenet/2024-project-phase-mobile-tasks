import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class UpdateProductUseCase extends BaseUsecase<ProductEntity, ProductEntity> {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await productRepository.updateProduct(product);
  }
}
