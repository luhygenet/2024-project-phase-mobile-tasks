import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:clean_architecture/features/product/domain/usecases/base_usecase.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_all_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ViewAllProductsUseCase viewAllProductsUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    viewAllProductsUseCase = ViewAllProductsUseCase(mockProductRepository);
  });

  const testReturnProducts = [
    ProductEntity(
        id: '2',
        name: 'first product',
        description: 'this is my first product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
    ProductEntity(
      id: '3',
      name: 'second product',
      description: 'this is my second product',
      imageUrl: 'assets/shoe2.jpeg',
      price: '7',
    ),
    ProductEntity(
        id: '4',
        name: 'third product',
        description: 'this is my third product',
        imageUrl: 'assets/shoe2.jpeg',
        price: '6'),
  ];

  test('should return all products', () async {
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => const Right(testReturnProducts));

    final result = await viewAllProductsUseCase(NoParams());

    print(testReturnProducts);
    expect(result, const Right(testReturnProducts));
  });
}
