import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadAllProductsEvent());
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
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                print(state);
                if (state is LoadingAllProduct) {
                  return CircularProgressIndicator();
                } else if (state is LoadedAllProducts) {
                  return Expanded(
                      child: ListView.separated(
                          itemCount: state.products.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (BuildContext content, int index) {
                            return ProductCard(state.products[index]);
                          }));
                } else if (state is LoadingAllProductsError) {
                  return Center(child: Text(state.message));
                } else {
                  print(state);
                  return Center(child: Text('No products'));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/add');
          //context.read<ProductBloc>().add(LoadAllProductsEvent());
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
