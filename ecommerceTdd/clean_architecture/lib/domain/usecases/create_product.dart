import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProductUseCase {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(ProductEntity product) async {
    return await productRepository.createProduct(product);
  }
  
}
