import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/Base_Usecase/base_usecase.dart';



class ViewAllProductsUseCase
    extends BaseUsecase<List<ProductEntity>, NoParams> {
  final ProductRepository productRepository;

  ViewAllProductsUseCase(this.productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await productRepository.getAllProducts();
  }
}

