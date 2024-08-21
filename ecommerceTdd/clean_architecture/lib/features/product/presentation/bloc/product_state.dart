import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

//single product
class IntialState extends ProductState {}

class ProductLoading extends ProductState {}

class LoadedSingleProductState extends ProductState {
  final ProductEntity product;

  const LoadedSingleProductState(this.product);
}

class ProductLoadError extends ProductState {
  final String message;

  const ProductLoadError(this.message);

  @override
  List<Object?> get props => [message];
}

//get all products

class LoadedAllProducts extends ProductState {
  final List<ProductEntity> products;
  const LoadedAllProducts(this.products);

  @override
  List<Object?> get props => [products];
}

class LoadingAllProduct extends ProductState {
  const LoadingAllProduct();
  @override
  List<Object?> get props => [];
}

class LoadingAllProductsError extends ProductState {
  final String message;

  const LoadingAllProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatedProduct extends ProductState {
  final ProductEntity product;

  const UpdatedProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class UpdatingProduct extends ProductState {
  const UpdatingProduct();
  @override
  List<Object?> get props => [];
}

class UpdateProductError extends ProductState {
  final String message;
  const UpdateProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreatedProduct extends ProductState {
  final ProductEntity product;

  const CreatedProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class CreatingProduct extends ProductState {
  const CreatingProduct();
  @override
  List<Object?> get props => [];
}

class CreateProductError extends ProductState {
  final String message;
  const CreateProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletedProduct extends ProductState {
  const DeletedProduct();
  @override
  List<Object?> get props => [];
}

class DeletingProduct extends ProductState {
  const DeletingProduct();
  @override
  List<Object?> get props => [];
}

class DeleteProductError extends ProductState {
  final String message;
  const DeleteProductError(this.message);

  @override
  List<Object?> get props => [message];
}
