import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/Base_Usecase/base_usecase.dart';

class ViewProductUsecase extends BaseUsecase<ProductEntity, Params> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(Params params) {
    return productRepository.getCurrentProduct(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object?> get props =>[id];
}
