import 'package:flutter/material.dart';
import 'package:task6/data/mock_data.dart';
import 'package:task6/models/product.dart';

void main() {
  runApp(Update());
}

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _image = TextEditingController();
  var image_url = '';

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
            title: Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                Text(
                  'Add product',
                )
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 226, 226),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      actions: [
                                        Column(
                                          children: [
                                            Text('Enter image URL:'),
                                            TextField(
                                              controller: _image,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder()),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  image_url = _image.text;
                                                },
                                                child: Text('enter'))
                                          ],
                                        )
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.image_outlined,
                            size: 50,
                          )),
                      Text('upload image')
                    ],
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomForm(
                  form_description: _description,
                  form_category: _category,
                  form_image: _image,
                  form_price: _price,
                  form_name: _name,
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        text: 'ADD',
                        onPressed: () {
                          print(image_url);
                          print('ezi');
                          print(_name.text);
                          print(_price.text);
                          print(_description.text);
                          print(_category.text);

                          mockData.add(Product(
                              image: image_url,
                              name: _name.text,
                              price: _price.text,
                              description: _description.text,
                              category: _category.text));
                        },
                        bC: Colors.white,
                        col: const Color.fromARGB(255, 7, 114, 202)),
                    SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                        text: 'DELETE',
                        onPressed: () {},
                        bC: const Color.fromARGB(255, 189, 22, 10),
                        col: Colors.white)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  final form_name;
  final form_description;
  final form_image;
  final form_price;
  final form_category;
  final form_dialog_controller;

  const CustomForm(
      {super.key,
      this.form_name,
      this.form_description,
      this.form_image,
      this.form_price,
      this.form_category,
      this.form_dialog_controller});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'name',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_name,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Color.fromARGB(255, 231, 226, 226)),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'category',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_category,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 231, 226, 226),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'price',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            )),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_price,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 231, 226, 226),
            hintText: '\$',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'description',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_description,
          maxLines: 5,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 231, 226, 226),
          ),
        ),
      ],
    ));
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bC;
  final col;

  CustomButton(
      {required this.text,
      required this.onPressed,
      required this.bC,
      required this.col});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 500,
        decoration: BoxDecoration(
            color: col,
            border: Border.all(color: bC),
            borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontSize: 20, color: bC),
            )),
          ),
        ));
  }
}
