import 'package:http/http.dart';

import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/domain/entities/product.dart';
// import 'package:bloc/bloc.dart';

void main() async {
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  productRemoteDataSourceImpl = ProductRemoteDataSourceImpl(client: Client());

  // getting all the products
  // final result = await productRemoteDataSourceImpl.getAllProducts();
  // print(result);
  // for (final product in result) {
  //   print(product.name);
  // }

  //deleting a product
  // await productRemoteDataSourceImpl.deleteProduct('66bdfad79bbe07fc3903515b');

  //getting a specific product
  // final product = await productRemoteDataSourceImpl
  //     .getCurrentProduct('66be01739bbe07fc39035201');

  //updating or creating a product just edit the method
  const product = ProductEntity(
      id: '66bf21aa3b4ddf8b56f355c8',
      name: 'newest product',
      description: 'home ',
      imageUrl: '/Users/dell/Desktop/che.jpg',
      price: 6889);
  await productRemoteDataSourceImpl.updateProduct(product);
}
