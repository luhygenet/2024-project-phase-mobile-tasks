import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class DeleteProductUseCase extends BaseUsecase<void, Params> {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(Params params) async {
    return await productRepository.deleteProduct(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object?> get props => throw UnimplementedError();
}
