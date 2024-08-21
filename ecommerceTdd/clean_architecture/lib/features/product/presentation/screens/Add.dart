import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

// void main() {
//   runApp(Add());
// }

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  //TextEditingController _imagexxxx = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image in _image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Add product',
              )
            ],
          )),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CreatedProduct) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product created successfully!')));
            context.read<ProductBloc>().add(LoadAllProductsEvent());
            Navigator.pop(context);
          }
          if (state is CreateProductError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'couldn\'t create product successfuly ${state.message}')));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 231, 226, 226),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.image_outlined,
                              size: 50,
                            )),
                        const Text('upload image')
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  form_description: _description,
                  form_category: _category,
                  form_image: _image,
                  form_price: _price,
                  form_name: _name,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        text: 'ADD',
                        onPressed: () {
                          print('press');
                          context.read<ProductBloc>().add(CreateProductEvent(
                              product: ProductEntity(
                                  id: '',
                                  name: _name.text,
                                  description: _description.text,
                                  imageUrl: _image!.path,
                                  price: int.parse(_price.text))));
                        },
                        bC: Colors.white,
                        col: const Color.fromARGB(255, 7, 114, 202)),
                    const SizedBox(
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
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'name',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_name,
          textAlign: TextAlign.end,
          decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Color.fromARGB(255, 231, 226, 226)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'category',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_category,
          textAlign: TextAlign.end,
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 231, 226, 226),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
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
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_price,
          textAlign: TextAlign.end,
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 231, 226, 226),
            hintText: '\$',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'enter price';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'description',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.form_description,
          maxLines: 5,
          textAlign: TextAlign.end,
          decoration: const InputDecoration(
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

  const CustomButton(
      {super.key,
      required this.text,
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
