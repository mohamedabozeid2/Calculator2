import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  String digit;
  Function clickFunction;

  CalculatorButton({
    required this.clickFunction,
    required this.digit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: MaterialButton(
          color: const Color.fromRGBO(0, 40, 110, 100),
          onPressed: () {
            clickFunction(digit);
          },
          child: Text(
            digit,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
            color: Colors.white),
          ),
        ),
      ),
    );
  }
}
