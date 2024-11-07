import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomNumberGenerator(),
    );
  }
}

class RandomNumberGenerator extends StatefulWidget {
  @override
  _RandomNumberGeneratorState createState() => _RandomNumberGeneratorState();
}

class _RandomNumberGeneratorState extends State<RandomNumberGenerator> {
  int? _randomNumber;
  bool _evenOnly = false;
  int _minValue = 1;
  int _maxValue = 100;

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  bool _minLabelClicked = false;
  bool _maxLabelClicked = false;

  void _generateRandomNumber() {
    setState(() {
      int number;
      do {
        number = Random().nextInt(_maxValue - _minValue + 1) + _minValue;
      } while (_evenOnly && number % 2 != 0);
      _randomNumber = number;
    });
  }

  // Funkcja generująca losowe hasło
  String _generatePassword() {
    const length = 12;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';
    return List.generate(length, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Generator Liczb'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  final password = _generatePassword();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordScreen(password: password),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Generuj hasło',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Text(
                  _randomNumber != null ? '$_randomNumber' : '',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Tylko parzyste"),
                    Switch(
                      value: _evenOnly,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _evenOnly = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Zakres liczb:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _minController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _minLabelClicked ? "Min" : "Min = 1",
                        ),
                        onTap: () {
                          if (!_minLabelClicked) {
                            setState(() {
                              _minLabelClicked = true;
                            });
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _minValue = int.tryParse(value) ?? 1;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        controller: _maxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _maxLabelClicked ? "Max" : "Max = 100",
                        ),
                        onTap: () {
                          if (!_maxLabelClicked) {
                            setState(() {
                              _maxLabelClicked = true;
                            });
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _maxValue = int.tryParse(value) ?? 100;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateRandomNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text(
                  'Generuj',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class PasswordScreen extends StatelessWidget {
  final String password;

  PasswordScreen({required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wygenerowane Hasło"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          password,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
