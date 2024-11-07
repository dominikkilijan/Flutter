import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password_generator.dart';

class RandomNumberGenerator extends StatefulWidget {
  @override
  _RandomNumberGeneratorState createState() => _RandomNumberGeneratorState();
}

class _RandomNumberGeneratorState extends State<RandomNumberGenerator> {
  int? _randomNumber;
  bool _evenOnly = false;
  bool _oddOnly = false;
  int _minValue = 1;
  int _maxValue = 100;

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  bool _minLabelClicked = false;
  bool _maxLabelClicked = false;

  void _generateRandomNumber() {
    setState(() {
      // Upewnij się, że wartości mieszczą się w określonych granicach
      _minValue = _minValue.clamp(-999999, 9999999);
      _maxValue = _maxValue.clamp(-999999, 9999999);

      // Jeśli Min jest większe niż Max, zamień wartości miejscami
      if (_minValue > _maxValue) {
        int temp = _minValue;
        _minValue = _maxValue;
        _maxValue = temp;
      }

      // Generuj liczbę w zakresie
      int number;
      do {
        number = Random().nextInt(_maxValue - _minValue + 1) + _minValue;
      } while ((_evenOnly && number % 2 != 0) || (_oddOnly && number % 2 == 0));
      _randomNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Generator Liczb',
          style: TextStyle(fontSize: 24),
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Generuj hasło',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Center(
                child: SelectableText(
                  _randomNumber != null ? '$_randomNumber' : '0',
                  style: TextStyle(fontSize: 84, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tylko parzyste", style: TextStyle(fontSize: 20)),
                        Switch(
                          value: _evenOnly,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _evenOnly = value;
                              if (value) _oddOnly = false;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tylko nieparzyste", style: TextStyle(fontSize: 20)),
                        Switch(
                          value: _oddOnly,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _oddOnly = value;
                              if (value) _evenOnly = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Zakres liczb:", style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _minController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _minLabelClicked ? "Min" : "Min = 1",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
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
                            _minValue = _minValue.clamp(-999999, 9999999);

                            // Jeśli Min jest większe niż Max, zamień wartości miejscami
                            if (_minValue > _maxValue) {
                              int temp = _minValue;
                              _minValue = _maxValue;
                              _maxValue = temp;

                              // Aktualizuj także pola tekstowe
                              _minController.text = '$_minValue';
                              _maxController.text = '$_maxValue';
                            } else {
                              _minController.text = '$_minValue';
                            }
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
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
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
                            _maxValue = _maxValue.clamp(-999999, 9999999);

                            // Jeśli Min jest większe niż Max, zamień wartości miejscami
                            if (_minValue > _maxValue) {
                              int temp = _minValue;
                              _minValue = _maxValue;
                              _maxValue = temp;

                              // Aktualizuj także pola tekstowe
                              _minController.text = '$_minValue';
                              _maxController.text = '$_maxValue';
                            } else {
                              _maxController.text = '$_maxValue';
                            }
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
                  textStyle: TextStyle(fontSize: 24),
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
