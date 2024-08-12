import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'base_usecase.dart';

class UpdateProductUseCase extends BaseUsecase<ProductEntity, Params> {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> call(Params params) async {
    return await productRepository.updateProduct(params.productEntity);
  }
}

class Params extends Equatable {
  final ProductEntity productEntity;

  Params({required this.productEntity});

  @override
  List<Object?> get props => throw UnimplementedError();
}
