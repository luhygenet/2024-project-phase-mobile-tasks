/* Product Manager Class: Create a class that manages products and includes the following methods:
Add a new product
View all products
View a single product
Edit a product (update name, description, price)
Delete a product */

void main() {
  ProductManager manager = ProductManager();

  // adding products
  print(" we started by adding a bunch of products");
  manager.addProduct("bag", "pretty", 1000);
  manager.addProduct("shoe", "pretty", 1000);
  manager.addProduct("shirt", "pretty", 1000);
  manager.addProduct("pc", "pretty", 1000);
  manager.addProduct("phone", "pretty", 1000);

  // showing added products
  print("This are all the products that we have");
  manager.showProducts();

  // deleting a product "bag"
  print("we deleted a certain product (bag in this case)");
  print("");
  manager.deleteProduct("bag");

  // showing a product by name
  print(
      "Here we show a certain product and its properties (shoe in this case)");
  manager.thisProduct("shoe");

  //editing a product
  print(
      "Here we edit a certain product(changed the name of show, can also do description or price)");
  print("");
  manager.editProduct("shoe", "name", "louis");

  manager.showProducts();

}

class Product {
  String? name_;
  String? description_;
  int? price_;

  Product(name, description, price){
    this.name_ = name;
    this.description_ = description;
    this.price_ = price;
  }

 
  String? get name => name_;

  
  set name(String? value) => name_ = value;


  String? get description => description_;


  set description(String? value) => description_ = value;


  int? get price => price_;

 
  set price(int? value) => price_ = value;
}

class ProductManager {
  List products = [];
  void addProduct(String name, description, int price) {
    Product p1 = Product(name, description, price);
    products.add([p1, (p1.name, p1.description, p1.price)]);
  }

  void showProducts() {
    for (var product in products) {
      print("Product Name: ${product[0].name}");
      print("Description: ${product[0].description}");
      print("Price: ${product[0].description}");
      print("");
    }
  }

  void thisProduct(String product_name) {
    for (var product in products) {
      if (product[0].name == product_name) {
        print("Product Name: ${product[0].name}");
        print("Description: ${product[0].description}");
        print("Price: ${product[0].description}");
        print("");
      }
    }
  }

  void editProduct(String product_name, String to_change, var change_to) {
    for (var product in products) {
      if (product[0].name == product_name) {
        if (to_change == "name") {
          product[0].name = change_to;
        } else if (to_change == "description") {
          product[0].description = change_to;
        } else {
          product[0].price = change_to;
        }
        break;
      }
      print("This product does not exist");
    }
  }

  void deleteProduct(String product_name) {
    for (var product in products) {
      if (product[0].name == product_name) {
        products.remove(product);
        break;
      }
      print("You can not delete a product that does not exist");
    }
  }
}
