import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Base_Usecase/base_usecase.dart';

class UpdateProductUseCase extends BaseUsecase<ProductEntity, UpdateParams> {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);
  
  @override
  Future<Either<Failure, ProductEntity>> call(UpdateParams params) async {
    return await productRepository.updateProduct(params.product);
  }
}

class UpdateParams extends Equatable {
  final ProductEntity product;

  const UpdateParams({required this.product});


  @override
  List<Object?> get props => [product];
}
