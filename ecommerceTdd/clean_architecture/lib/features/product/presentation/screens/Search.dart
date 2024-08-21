import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';    
import '../widgets/product_card.dart';

void main() {
  runApp(Search());
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RangeValues _currentRange = RangeValues(10, 100);
  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(const LoadAllProductsEvent());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Row(
          children: [
            SizedBox(
              width: 70,
            ),
            Text('Search Product')
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                    width: 270,
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          suffix: Icon(
                            Icons.arrow_right_alt_sharp,
                            size: 20,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Leather'),
                    )),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 60,
                  child: OutlinedButton(
                      onPressed: () {
                        print('pressed');
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 30, 15, 20),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text('price'),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        RangeSlider(
                                          min: 10,
                                          max: 100,
                                          values: _currentRange,
                                          onChanged: (RangeValues value) {
                                            setState(() {
                                              _currentRange = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 31, 107, 168),
                              width: 2), // Border color and width
                          backgroundColor: Colors.blue
                          // Background color when pressed
                          ),
                      child: const Icon(Icons.filter_list)),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductLoadError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is LoadedAllProducts) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(state.products[index]);
                          }));
                } else {
                  return const Center(
                      child: Text('No products to search from'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
