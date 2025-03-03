import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  double num1 = 0, num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
        num1 = num2 = 0;
        operand = "";
      } else if (buttonText == "=") {
        num2 = double.parse(output);
        if (operand == "+") output = (num1 + num2).toString();
        if (operand == "-") output = (num1 - num2).toString();
        if (operand == "*") output = (num1 * num2).toString();
        if (operand == "/") output = (num1 / num2).toString();
        operand = "";
      } else if (["+", "-", "*", "/"].contains(buttonText)) {
        num1 = double.parse(output);
        operand = buttonText;
        output = "0";
      } else {
        output = output == "0" ? buttonText : output + buttonText;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(text),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(24),
              child: Text(output, style: TextStyle(fontSize: 48)),
            ),
          ),
          ...["7 8 9 /", "4 5 6 *", "1 2 3 -", "C 0 = +"].map((row) =>
              Row(children: row.split(" ").map(buildButton).toList()))
        ],
      ),
    );
  }
}
