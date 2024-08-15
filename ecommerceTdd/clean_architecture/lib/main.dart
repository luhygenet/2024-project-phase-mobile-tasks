import 'package:http/http.dart';

import 'features/product/data/data_sources/remote_data_source.dart';

void main() async {
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  productRemoteDataSourceImpl = ProductRemoteDataSourceImpl(client: Client());

  final result = await productRemoteDataSourceImpl.getAllProducts();
  print(result);
  for (final product in result) {
    print(product.name);
  }

}
