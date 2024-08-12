import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class DeleteProductUseCase extends BaseUsecase<void, String> {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(String id) async {
    return await productRepository.deleteProduct(id);
  }
}
