import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: BMICalculator()));

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 170, weight = 70, bmi = 0;

  void calculateBMI() => setState(() => bmi = weight / ((height / 100) * (height / 100)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Column(
        children: [
          for (var label in ['Height (cm)', 'Weight (kg)'])
            TextField(
              decoration: InputDecoration(labelText: label),
              keyboardType: TextInputType.number,
              onChanged: (value) => label.contains('Height') ? height = double.parse(value) : weight = double.parse(value),
            ),
          ElevatedButton(onPressed: calculateBMI, child: Text('Calculate BMI')),
          Text('BMI: ${bmi.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
