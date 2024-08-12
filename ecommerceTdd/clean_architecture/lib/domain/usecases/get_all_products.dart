import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class Noparams {}

class ViewAllProductsUseCase
    extends BaseUsecase<List<ProductEntity>, Noparams> {
  final ProductRepository productRepository;

  ViewAllProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> call(Noparams) async {
    return await productRepository.getAllProducts();
  }
}
