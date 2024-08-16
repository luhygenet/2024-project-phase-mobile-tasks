import '../../features/product/domain/entities/product.dart';

class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1';
  static String getcurrentProductById(String id) => '$baseUrl/products/$id';
  static String getAllproducts() => '$baseUrl/products';
  static String createProduct() => '$baseUrl/products';
  static String updateProduct(ProductEntity product) =>
      '$baseUrl/products/${product.id}';
  static String deleteProduct(String id) => '$baseUrl/products/$id';
}
