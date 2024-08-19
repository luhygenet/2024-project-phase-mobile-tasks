import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetSingleProductEvent extends ProductEvent {
  final String id;

  const GetSingleProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadAllProductsEvent extends ProductEvent {

  const LoadAllProductsEvent();

  @override
  List<Object?> get props => [];
}


class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;
  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity product;
  const CreateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
