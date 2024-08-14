
class Urls {
  static const String baseUrl = 'https://products';
  static const String apiKey = 'productsKey';
  static String getcurrentProductById(String id) => '$baseUrl/products/$id';
  static String getAllproducts() => '$baseUrl/products/';
  static String createProduct() => '$baseUrl/products';
  static String updateProduct(String id) => '$baseUrl/products/$id';
  static String deleteProduct(String id) => '$baseUrl/product/$id';
}
