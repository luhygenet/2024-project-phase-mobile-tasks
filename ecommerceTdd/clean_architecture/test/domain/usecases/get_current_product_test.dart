import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/usecases/get_current_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ViewProductUsecase viewProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    viewProductUsecase = ViewProductUsecase(mockProductRepository);
  });

  const testProductDetail = ProductEntity(
      id: '2',
      name: 'first product',
      description: 'this is my first product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '6');

  const testProductId = '2';

  test('should return product with specified id', () async {
    // arrange
    when(mockProductRepository.getCurrentProduct(testProductId))
        .thenAnswer((_) async => const Right(testProductDetail));
    // act
    final result = await viewProductUsecase(Params(id: testProductId));

    // assert
    expect(result, const Right(testProductDetail));
  });
}
