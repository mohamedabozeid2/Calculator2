
import 'package:flutter/material.dart';
import 'dart:math';
import 'CalculatorButton.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";

  double finalResult = 0.0;

  bool finalResultReached = false;

  String operator = "";

  String lhs = "";

  String rhs = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.2,
        title: const Text("Calculator"),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        result == "" ? "0.0" : result,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          finalResult.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          operator,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalculatorButton(digit: "C", clickFunction: onCButton),
                  CalculatorButton(digit: "DEL", clickFunction: onDeleteButton),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalculatorButton(digit: "7", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "8", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "9", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "*", clickFunction: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalculatorButton(digit: "4", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "5", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "6", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "/", clickFunction: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalculatorButton(digit: "1", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "2", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "3", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "+", clickFunction: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalculatorButton(digit: "0", clickFunction: onDigitClicked),
                  CalculatorButton(digit: ".", clickFunction: onDigitClicked),
                  CalculatorButton(digit: "=", clickFunction: onEqualClick),
                  CalculatorButton(digit: "-", clickFunction: onOperatorClick),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDigitClicked(String digit) {
    print(finalResultReached);

    if(finalResultReached){
      result = "";
      finalResultReached = false;
    }

    result += digit;
    print("FROM DIGIT LHS $lhs --- Operator $operator --- RHS $rhs --- Result $result");

    setState(() {});
  }

  void onOperatorClick(String operatorClicked) {
    if (lhs == "") {
      lhs = result;
    } else {
      rhs = result;
      lhs = calculate(lhs, operator, rhs).toString();
      finalResult = double.parse(lhs);
    }
    operator = operatorClicked;
    result = "";
    print("LHS $lhs -- RHS $rhs");

    setState(() {});
  }

  double calculate(String lhs, String operator, String rhs) {
    double lhsAsDouble = double.parse(lhs);
    double rhsAsDouble = double.parse(rhs);
    if (operator == "+") {
      return lhsAsDouble + rhsAsDouble;
    } else if (operator == "-") {
      return lhsAsDouble - rhsAsDouble;
    } else if (operator == "*") {
      return lhsAsDouble * rhsAsDouble;
    } else {
      return lhsAsDouble / rhsAsDouble;
    }

  }

  void onEqualClick(String digit) {
    print("LHS $lhs --- Operator $operator --- RHS $rhs --- Result $result");
    if (lhs.isEmpty || result.isEmpty || operator.isEmpty) {
      print(digit);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Wrong Format"),
            );
          });
    } else {
      rhs = result;
      result = calculate(lhs, operator, rhs).toString();
      finalResult = double.parse(result);
      lhs = "";
      finalResultReached = true;
    }
    setState(() {

    });
  }

  onCButton(String digit) {
    finalResultReached =false;
    result = '';
    operator = '';
    lhs = '';
    rhs = '';
    finalResult = 0.0;
    setState(() {

    });
    print("LHS = $lhs \n RHS = $rhs \n operator = $operator \n");
  }

  onDeleteButton(String digit){
    result = (((int.parse(result))/10).floor()).toString();
    setState(() {

    });
  }
}
