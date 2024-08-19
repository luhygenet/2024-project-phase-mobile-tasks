import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Base_Usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductUseCase extends BaseUsecase<ProductEntity, CreateParams> {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(CreateParams params) async {
    return await productRepository.createProduct(params.product);
  }
}

class CreateParams extends Equatable {
  final ProductEntity product;

  const CreateParams({required this.product});
  
  @override
  List<Object?> get props => [product];
}
