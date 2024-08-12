import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/usecases/update_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateProductUseCase updateProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProductUseCase = UpdateProductUseCase(mockProductRepository);
  });
  const tobeupdatedProduct = ProductEntity(
      id: '2',
      name: 'first product',
      description: 'this is my first product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '6');

  const updatedProduct = ProductEntity(
      id: '2',
      name: 'first product',
      description: 'this is my first product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '6');

  test('should update product and return updated product', () async {
    when(mockProductRepository.updateProduct(tobeupdatedProduct))
        .thenAnswer((_) async => const Right(updatedProduct));

    final result = await updateProductUseCase(Params(productEntity: updatedProduct));

    expect(result, const Right(updatedProduct));
  });
}
