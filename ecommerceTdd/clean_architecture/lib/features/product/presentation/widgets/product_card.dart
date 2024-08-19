import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../screens/details.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductCard(this.productEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProductDetailsPage(),
            settings: RouteSettings(arguments: productEntity)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset(
                'assets/boot.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productEntity.name,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text('\$${productEntity.price}'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
