import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/Base_Usecase/base_usecase.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_current_product.dart';
import '../../domain/usecases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewProductUsecase viewProductUsecase;
  final ViewAllProductsUseCase viewAllProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final CreateProductUseCase createProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductBloc(
      {required this.viewProductUsecase,
      required this.viewAllProductsUseCase,
      required this.updateProductUseCase,
      required this.createProductUseCase,
      required this.deleteProductUseCase})
      : super(IntialState()) {


    on<GetSingleProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await viewProductUsecase(Params(id: event.id));
      result.fold((failure) {
        emit(ProductLoadError(failure.message));
      }, (data) {
        emit(LoadedSingleProductState(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));



    on<LoadAllProductsEvent>((event, emit) async {
      emit(const LoadingAllProduct());
      final result = await viewAllProductsUseCase(NoParams());
      result.fold((failure) {
        emit(LoadingAllProductsError(failure.message));
      }, (data) {
        emit(LoadedAllProducts(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));



    on<CreateProductEvent>((event, emit) async {
      emit(const CreatingProduct());
      final result =
          await createProductUseCase(CreateParams(product: event.product));
      result.fold((failure) {
        emit(CreateProductError(failure.message));
      }, (data) {
        emit(CreatedProduct(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));



    on<DeleteProductEvent>((event, emit) async {
      emit(const DeletingProduct());
      final result = await deleteProductUseCase(DeleteParams(id: event.id));
      result.fold((failure) {
        emit(DeleteProductError(failure.message));
      }, (data) {
        emit(const DeletedProduct());
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));



    on<UpdateProductEvent>((event, emit) async {
      emit(const UpdatingProduct());
      final result =
          await updateProductUseCase(UpdateParams(product: event.product));
      result.fold((failure) {
        emit(UpdateProductError(failure.message));
      }, (data) {
        emit(UpdatedProduct(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
