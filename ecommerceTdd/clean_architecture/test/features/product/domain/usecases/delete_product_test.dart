import 'package:clean_architecture/features/product/domain/usecases/delete_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository);
  });

  const testProductId = '2';

  test('should delete product with specified id', () async {
    // arrange
    when(mockProductRepository.deleteProduct(testProductId))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await deleteProductUseCase(Params(id: testProductId));

    // assert
    expect(result, const Right(null));
  });
}

  