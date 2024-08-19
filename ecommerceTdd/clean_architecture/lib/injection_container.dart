import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/product/data/data_sources/local_data_source.dart';
import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_current_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;
Future <void> init() async {
  //! features - product
  // Bloc

  sl.registerFactory(() => ProductBloc(
      viewProductUsecase: sl(),
      viewAllProductsUseCase: sl(),
      updateProductUseCase: sl(),
      createProductUseCase: sl(),
      deleteProductUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));

  //Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productLocalDataSource: sl(),
      networkInfo: sl(),
      productRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  //! core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
      sl())); //unnamed requirement of networkinfoimpl: connectionchecker

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() =>InternetConnectionChecker());
}
