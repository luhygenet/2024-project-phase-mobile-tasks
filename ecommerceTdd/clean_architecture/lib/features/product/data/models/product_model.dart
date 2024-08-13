import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.price});

  factory ProductModel.fromJsn(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price']);
  }

   Map<String, dynamic> tojsn() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price
    };
  }
}
