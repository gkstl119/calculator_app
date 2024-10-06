import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String displayText = ''; // To store input and result
  String history = ''; // To store calculation history
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // Clear the display, reset everything
        displayText = '';
        history = '';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        num1 = double.parse(displayText);
        operator = value;
        history = '$num1 $operator'; // Display the first operand and operator
        displayText = '';
      } else if (value == '=') {
        num2 = double.parse(displayText);
        if (operator == '+') {
          displayText = (num1 + num2).toString();
        } else if (operator == '-') {
          displayText = (num1 - num2).toString();
        } else if (operator == '*') {
          displayText = (num1 * num2).toString();
        } else if (operator == '/') {
          if (num2 != 0) {
            displayText = (num1 / num2).toString();
          } else {
            displayText = 'Error'; // Handle division by zero
          }
        }
        history =
            '$num1 $operator $num2 = $displayText'; // Update history after result
      } else {
        displayText += value; // Concatenate numbers
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // History Area (to show first operand and previous calculations)
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              history,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
          // Display Area (for current input and result)
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Number Buttons and Operators
          Row(
            children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("+"),
            ],
          ),
          Row(
            children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("-"),
            ],
          ),
          Row(
            children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("*"),
            ],
          ),
          Row(
            children: [
              buildButton("0"),
              buildButton("/"),
              buildButton("="),
            ],
          ),
          Row(
            children: [
              buildButton("C"), // Clear button
            ],
          ),
        ],
      ),
    );
  }

  // Button Builder
  Widget buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(value),
          child: Text(value, style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
