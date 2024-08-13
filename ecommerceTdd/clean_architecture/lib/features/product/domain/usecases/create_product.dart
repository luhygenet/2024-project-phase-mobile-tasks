import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'base_usecase.dart';

class CreateProductUseCase extends BaseUsecase<ProductEntity, Params> {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(Params params) async {
    return await productRepository.createProduct(params.product);
  }
}

class Params extends Equatable {
  final ProductEntity product;

  Params({required this.product});
  
  @override
  List<Object?> get props => throw UnimplementedError();
}
