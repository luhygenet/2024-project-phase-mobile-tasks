import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';
import '../../../../core/Base_Usecase/base_usecase.dart';

class DeleteProductUseCase extends BaseUsecase<void, DeleteParams> {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(DeleteParams params) async {
    return await productRepository.deleteProduct(params.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
