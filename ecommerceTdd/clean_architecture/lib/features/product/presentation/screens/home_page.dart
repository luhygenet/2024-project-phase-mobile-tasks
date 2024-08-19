import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../presentation/mock_data.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 192, 187, 187),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 7,2024',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(
                    color: Color.fromARGB(255, 104, 101, 101),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Yohannes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(30),
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Icon(Icons.notifications_on_outlined)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Products',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      child: const Icon(Icons.search_outlined))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: mockData.length,
                    itemBuilder: (BuildContext content, int index) {
                      return ProductCard(
                        mockData[index]
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final product =
              await Navigator.pushNamed(context, '/update') as ProductEntity;
          setState(() {
            mockData.add(product);
          });
        },
        backgroundColor: const Color.fromARGB(255, 16, 114, 194),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
