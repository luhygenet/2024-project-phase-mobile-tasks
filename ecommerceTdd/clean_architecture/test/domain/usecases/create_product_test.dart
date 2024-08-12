import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/usecases/create_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late CreateProductUseCase createProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    createProductUseCase = CreateProductUseCase(mockProductRepository);
  });

  const testProduct = ProductEntity(
    id: '2',
    name: 'first product',
    description: 'this is my first product',
    imageUrl: 'assets/shoe2.jpeg',
    price: '6',
  );

  test('should create a return created product', () async {
    when(mockProductRepository.createProduct(testProduct))
        .thenAnswer((_) async => const Right(testProduct));

    final result = await createProductUseCase(Params(product: testProduct));

    expect(result, const Right(testProduct));
  });
}
