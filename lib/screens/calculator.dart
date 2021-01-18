import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String output = "0";
  String _output = "0";
  String operand = "";
  double num1 = 0.0;
  double num2 = 0.0;
  
  buttonPressed(String s){
    if(s=="CLEAR"){
      setState(() {
        _output = "0";
        operand = "";
        num1 = 0.0;
        num2 = 0.0;
      });
    }
    else if(s=="+" || s=="-" || s=="x" || s=="/"){
      // case of operand 
      operand = s;
      num1 = double.parse(output);
      _output = "0";
    }
    else if (s=="."){
      if( ! _output.contains(".")) _output = _output + s; // concatination
    }
    else if(s=="="){
      num2 = double.parse(output);
      if(operand=="+") _output = (num1 + num2).toString();
      if(operand=="-") _output = (num1 - num2).toString();
      if(operand=="x") _output = (num1 * num2).toString();
      if(operand=="/") _output = (num1 / num2).toString();
      num1=0.0 ;
      num2=0.0 ;
      operand="";
    }
    else{
      _output = _output + s ; 
    }
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });

  }

  Widget buildElement(String s) {
    return Expanded(
      child: OutlineButton(
        child: Text(
          s,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            ),
        ),
        textColor: Colors.black,
        padding: EdgeInsets.all(25.0),
        onPressed:() => buttonPressed(s),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical : 24.0,
              horizontal : 12.0,
            ),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 48.0,
                  fontWeight: FontWeight.bold,
              )
              ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            children: <Widget>[
              buildElement('7'),
              buildElement('8'),
              buildElement('9'),
              buildElement("/"),
            ],
          ),
          Row(
            children: <Widget>[
              buildElement('4'),
              buildElement('5'),
              buildElement('6'),
              buildElement("x"),
            ],
          ),
          Row(
            children: <Widget>[
              buildElement('3'),
              buildElement('2'),
              buildElement('1'),
              buildElement("-"),
            ],
          ),
          Row(
            children: <Widget>[
              buildElement('.'),
              buildElement('0'),
              buildElement('00'),
              buildElement("+"),
            ],
          ),
          Row(
            children: <Widget>[
              buildElement("CLEAR"),
              buildElement("="),
            ],
          )
        ],
      ),
    );
  }
}