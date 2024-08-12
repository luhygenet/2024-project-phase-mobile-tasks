import 'package:flutter/material.dart';
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
        width: 150,
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