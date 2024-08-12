import 'package:flutter/material.dart';
import 'package:task6/data/mock_data.dart';
import 'package:task6/widgets/product_card.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
              Expanded(
                  child: ListView.builder(
                      itemCount: mockData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          image: mockData[index].image,
                          name: mockData[index].name,
                          price: mockData[index].price,
                          category: mockData[index].category,
                          description: mockData[index].description,
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
