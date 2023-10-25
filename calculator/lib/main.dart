import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String display = '0';
  double valor1 = 0;
  double valor2 = 0;
  String operator = "";
  bool puntoIngresado = false;
  bool secondvalue = false;
  bool equalscomb = false;

  void _onButtonPressed(String text) {
    String eliminarCerosFinales(String value) {
      if (value.endsWith('.0')) {
        return value.substring(0, value.length - 2);
      } else {
        return value;
      }
    }

    setState(() {
      switch (text) {
        case 'C':
          display = '0';
          puntoIngresado = false;
          break;
        case '+':
          valor1 = double.parse(display);
          operator = "+";
          secondvalue = true;
          equalscomb = false;
          break;
        case '-':
          valor1 = double.parse(display);
          operator = "-";
          secondvalue = true;
          equalscomb = false;
          break;
        case 'x':
          valor1 = double.parse(display);
          operator = "x";
          secondvalue = true;
          equalscomb = false;
          break;
        case '/':
          valor1 = double.parse(display);
          operator = "/";
          secondvalue = true;
          equalscomb = false;
          break;
        case '=':
          if (!equalscomb) {
            valor2 = double.parse(display);
          }
          try {
            switch (operator) {
              case '+':
                if (equalscomb) {
                  valor1 = double.parse(display);
                  valor1 += valor2;
                }
                else {
                  valor1 += valor2;
                }
                break;
              case '-':
                if (equalscomb) {
                  valor1 = double.parse(display);
                  valor1 -= valor2;
                }
                else {
                  valor1 -= valor2;
                }
                break;
              case 'x':
                if (equalscomb) {
                  valor1 = double.parse(display);
                  valor1 *= valor2;
                }
                else {
                  valor1 *= valor2;
                }
                break;
              case '/':
                if (valor2 != 0) {
                  if (equalscomb) {
                    valor1 = double.parse(display);
                    valor1 /= valor2;
                  }
                  else {
                    valor1 /= valor2;
                  }
                } else {
                  throw Exception('División entre cero');
                }
                break;
            }
            display = eliminarCerosFinales(valor1.toString());
            equalscomb = true;
            secondvalue = true;
          } catch (e) {
            display = 'Error';
          }
          break;
        case 'CE':
          valor1 = 0;
          valor2 = 0;
          operator = "";
          puntoIngresado = false;
          secondvalue = false;
          display = '0';
          equalscomb = false;
          break;
        case '<-':
          if (display.length > 1) {
            if (display.length == 2 && display.startsWith('-')) {
              display = '0';
            } else {
              display = display.substring(0, display.length - 1);
            }
          }
          else {
            display = '0';
          }
          puntoIngresado = display.contains('.');
          break;
        case '+-':
          if (display != '0' && display != 'Error') {
            if (!display.startsWith('-')) {
              display = '-' + display;
            } else {
              display = display.substring(1);
            }
          }
          break;
        case '.':
          if (!puntoIngresado) {
            if (secondvalue) {
              display = '0.';
              secondvalue = false;
            } else {
              display += '.';
            }
            puntoIngresado = true;
          }
          break;
        default:
          if (display == '0' || display == 'Error') {
            display = text;
          } else {
            if (secondvalue) {
              display = "";
              secondvalue = false;
              puntoIngresado = false;
            }
            display += text;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(
              display,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildOperator('CE'),
                  _buildOperator('C'),
                  _buildOperator('<-'),
                  _buildOperator('/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildKeyPad('7'),
                  _buildKeyPad('8'),
                  _buildKeyPad('9'),
                  _buildOperator('x'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildKeyPad('4'),
                  _buildKeyPad('5'),
                  _buildKeyPad('6'),
                  _buildOperator('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildKeyPad('1'),
                  _buildKeyPad('2'),
                  _buildKeyPad('3'),
                  _buildOperator('+'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildOperator('+-'),
                  _buildKeyPad('0'),
                  _buildOperator('.'),
                  _buildOperator('='),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPad(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          onPressed: () {
            _onButtonPressed(text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
  Widget _buildOperator(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          onPressed: () {
            _onButtonPressed(text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white70,
            minimumSize: const Size(double.infinity, 60),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}