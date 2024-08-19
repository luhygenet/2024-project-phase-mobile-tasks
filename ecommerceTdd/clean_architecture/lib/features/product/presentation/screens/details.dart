import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../widgets/custom_button.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productEntity =
        ModalRoute.of(context)?.settings.arguments as ProductEntity;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  'assets/boot.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 25.0,
                left: 16.0,
                child: IconButton.outlined(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              ),
            ]),
            Container(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Men\'s shoe',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '(4.0)',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productEntity.name,
                            style: const TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 51, 50, 50),
                                fontWeight: FontWeight.bold),
                          ),
                          Text('\$${productEntity.price}'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(13),
                    child: Text(
                      "Size:",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildcontainer(7),
                  ),
                ),
                Row(children: []),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    productEntity.description,
                    maxLines: 10,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: CustomButton(
                          onPressed: () {},
                          text: "Delete",
                          bC: const Color.fromARGB(255, 189, 22, 10),
                          col: null),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: CustomButton(
                          onPressed: () {},
                          text: "Update",
                          bC: Colors.white,
                          col: Colors.blue),
                    )
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

List<SizedBox> _buildcontainer(int count) {
  List<SizedBox> containers = List.generate(count, (int index) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Card(
          color: index + 40 == 41
              ? const Color.fromARGB(255, 34, 122, 194)
              : Colors.white,
          child: Center(child: Text('${index + 40} '))),
    );
  });
  return containers;
}