

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/core/Base_Usecase/base_usecase.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product.dart';
import 'package:clean_architecture/features/product/domain/usecases/create_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/delete_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_current_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/update_product.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';




void main() {
  late MockViewProductUsecase mockViewProductUsecase;
  late MockViewAllProductsUseCase mockViewAllProductsUseCase;
  late MockCreateProductUseCase mockCreateProductUseCase;
  late MockUpdateProductUseCase mockUpdateProductUseCase;
  late MockDeleteProductUseCase mockDeleteProductUseCase;
  late ProductBloc productBloc;

  setUp(() {
    mockViewProductUsecase = MockViewProductUsecase();
    mockViewAllProductsUseCase = MockViewAllProductsUseCase();
    mockUpdateProductUseCase = MockUpdateProductUseCase();
    mockCreateProductUseCase = MockCreateProductUseCase();
    mockDeleteProductUseCase = MockDeleteProductUseCase();
    productBloc = ProductBloc(
        viewProductUsecase: mockViewProductUsecase,
        viewAllProductsUseCase: mockViewAllProductsUseCase,
        updateProductUseCase: mockUpdateProductUseCase,
        createProductUseCase: mockCreateProductUseCase,
        deleteProductUseCase: mockDeleteProductUseCase);
  });

  const testProductDetail = ProductEntity(
      id: '2',
      name: 'first product',
      description: 'this is my first product',
      imageUrl: 'assets/shoe2.jpeg',
      price: 6);

  const testProductId = '2';


  const testReturnProducts = [
    ProductEntity(
        id: '2',
        name: 'first product',
        description: 'this is my first product',
        imageUrl: 'assets/shoe2.jpeg',
        price: 6),
    ProductEntity(
      id: '3',
      name: 'second product',
      description: 'this is my second product',
      imageUrl: 'assets/shoe2.jpeg',
      price: 7,
    ),
    ProductEntity(
        id: '4',
        name: 'third product',
        description: 'this is my third product',
        imageUrl: 'assets/shoe2.jpeg',
        price: 6),
  ];



  test('initial state is productEmpty', () {
    expect(productBloc.state, IntialState());
  });


  //loading single product event
  blocTest<ProductBloc, ProductState>(
    'should emit [product loading] then [product loaded]',
    build: () {
      when(mockViewProductUsecase.call(Params(id: testProductId)))
          .thenAnswer((_) async => const Right(testProductDetail));
      return productBloc;
    },
    act: (bloc) => bloc.add(const GetSingleProductEvent(testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [ProductLoading(), const LoadedSingleProductState(testProductDetail)],
  );


  //loading single product event server failure
   blocTest<ProductBloc, ProductState>(
    'should emit [product loading] then [product loading server failure]',
    build: () {
      when(mockViewProductUsecase.call(Params(id: testProductId)))
          .thenAnswer((_) async => const Left(ServerFailure('server error when loading the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const GetSingleProductEvent(testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [ProductLoading(), const ProductLoadError('server error when loading the product')],
  );



   //loading single product event socket failure
   blocTest<ProductBloc, ProductState>(
    'should emit [product loading] then [product loading socket failure]',
    build: () {
      when(mockViewProductUsecase.call(Params(id: testProductId)))
          .thenAnswer((_) async => const Left(SocketFailure('socket error when loading the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const GetSingleProductEvent(testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [ProductLoading(), const ProductLoadError('socket error when loading the product')],
  );

  
  //loading all products event
  blocTest<ProductBloc, ProductState>(
    'should emit [all products loading] then [all products loaded]',
    build: () {
      when(mockViewAllProductsUseCase.call(NoParams()))
          .thenAnswer((_) async => const Right(testReturnProducts));
      return productBloc;
    },
    act: (bloc) => bloc.add(const LoadAllProductsEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const LoadingAllProduct(),
      const LoadedAllProducts(testReturnProducts)
    ],
  );

  
  //loading all products event server failure
  blocTest<ProductBloc, ProductState>(
    'should emit [all products loading] then [all products loading server failure]',
    build: () {
      when(mockViewAllProductsUseCase.call(NoParams())).thenAnswer((_) async =>
          const Left(ServerFailure('server error when loading all products')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const LoadAllProductsEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const LoadingAllProduct(),
      const LoadingAllProductsError('server error when loading all products')
    ],
  );


  //loading all products event socket failure
  blocTest<ProductBloc, ProductState>(
    'should emit [all products loading] then [all products loading socket failure]',
    build: () {
      when(mockViewAllProductsUseCase.call(NoParams())).thenAnswer((_) async =>
          const Left(SocketFailure('socket error when loading all products')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const LoadAllProductsEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const LoadingAllProduct(),
      const LoadingAllProductsError('socket error when loading all products')
    ],
  );


  //updating product event
  blocTest<ProductBloc, ProductState>(
    'should emit [updating product] then [updated product]',
    build: () {
      when(mockUpdateProductUseCase
              .call(const UpdateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Right(testProductDetail));
      return productBloc;
    },
    act: (bloc) => bloc.add(const UpdateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [const UpdatingProduct(), const UpdatedProduct(testProductDetail)],
  );


  //updating product event Server failure
  blocTest<ProductBloc, ProductState>(
    'should emit [updating product] then [updating product server failure]',
    build: () {
      when(mockUpdateProductUseCase
              .call(const UpdateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Left(
              ServerFailure('Server failure in updating the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const UpdateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const UpdatingProduct(),
      const UpdateProductError('Server failure in updating the product')
    ],
  );


  //updating product event Socket failure
  blocTest<ProductBloc, ProductState>(
    'should emit [updating product] then [updating product socket failure]',
    build: () {
      when(mockUpdateProductUseCase
              .call(const UpdateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Left(
              SocketFailure('Socket failure in updating the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const UpdateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const UpdatingProduct(),
      const UpdateProductError('Socket failure in updating the product')
    ],
  );



  //creating product event
  blocTest<ProductBloc, ProductState>(
    'should emit [creating product] then [created product]',
    build: () {
      when(mockCreateProductUseCase
              .call(const CreateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Right(testProductDetail));
      return productBloc;
    },
    act: (bloc) => bloc.add(const CreateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [const CreatingProduct(), const CreatedProduct(testProductDetail)],
  );

  
  //creating product event Server failure
  blocTest<ProductBloc, ProductState>(
    'should emit [creating product] then [creating product server failure]',
    build: () {
      when(mockCreateProductUseCase
              .call(const CreateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Left(
              ServerFailure('Server failure in creating the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const CreateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const CreatingProduct(),
      const CreateProductError('Server failure in creating the product')
    ],
  );

  //creating product event Socket failure
  blocTest<ProductBloc, ProductState>(
    'should emit [creating product] then [creating product server failure]',
    build: () {
      when(mockCreateProductUseCase
              .call(const CreateParams(product: testProductDetail)))
          .thenAnswer((_) async => const Left(
              SocketFailure('Socket failure in creating the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const CreateProductEvent(testProductDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const CreatingProduct(),
      const CreateProductError('Socket failure in creating the product')
    ],
  );


  //deleting product event
  blocTest<ProductBloc, ProductState>(
    'should emit [deleting product] then [deleted product]',
    build: () {
      when(mockDeleteProductUseCase.call(const DeleteParams(id: testProductId)))
          .thenAnswer((_) async => const Right(null));
      return productBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [const DeletingProduct(), const DeletedProduct()],
  );


  //deleting product event server failure
  blocTest<ProductBloc, ProductState>(
    'should emit [deleting product] then [deleted product]',
    build: () {
      when(mockDeleteProductUseCase.call(const DeleteParams(id: testProductId)))
          .thenAnswer((_) async => const Right(null));
      return productBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [const DeletingProduct(), const DeletedProduct()],
  );


  //deleting the product event socket failure
  blocTest<ProductBloc, ProductState>(
    'should emit [deleting product] then [deleted product]',
    build: () {
      when(mockDeleteProductUseCase.call(const DeleteParams(id: testProductId)))
          .thenAnswer((_) async => const Left(ServerFailure('server error when deleting the product')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: testProductId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [const DeletingProduct(), const DeleteProductError('server error when deleting the product')],
  );
}
