import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class ViewProductUsecase extends BaseUsecase<ProductEntity, String> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  Future<Either<Failure, ProductEntity>> call(String id) {
    return productRepository.getCurrentProduct(id);
  }
}
