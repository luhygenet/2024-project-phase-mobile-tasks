
import 'package:clean_architecture/domain/usecases/delete_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository);
  });

  const testProductId = '2';

  test('should delete specified product', () async {
    // arrange
    when(mockProductRepository.deleteProduct(testProductId))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await deleteProductUseCase.execute(testProductId);

    // assert
    expect(result, const Right(null));
  });
}