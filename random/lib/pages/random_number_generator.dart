import 'dart:math';
import 'package:flutter/material.dart';
import 'password_generator.dart';

class RandomNumberGenerator extends StatefulWidget {
  const RandomNumberGenerator({super.key});
  @override
  RandomNumberGeneratorState createState() => RandomNumberGeneratorState();
}

class RandomNumberGeneratorState extends State<RandomNumberGenerator> {
  int? _randomNumber;
  bool _evenOnly = false;
  bool _oddOnly = false;
  int _minValue = 1;
  int _maxValue = 100;

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = '$_minValue';
    _maxController.text = '$_maxValue';
  }

  void _generateRandomNumber() {
    setState(() {
      // Pobieramy wartości z pól tekstowych
      _minValue = int.tryParse(_minController.text) ?? 1;
      _maxValue = int.tryParse(_maxController.text) ?? 100;

      // Ograniczenie wartości do ustalonego zakresu
      _minValue = _minValue.clamp(-999999, 9999999);
      _maxValue = _maxValue.clamp(-999999, 9999999);

      // Zamiana wartości, jeśli Min jest większy niż Max
      if (_minValue > _maxValue) {
        int temp = _minValue;
        _minValue = _maxValue;
        _maxValue = temp;
      }

      // Jeśli Min i Max są sobie równe, zwiększamy Max o 1
      if (_minValue == _maxValue) {
        _maxValue += 1;
      }

      // Aktualizujemy pola tekstowe, aby pokazać poprawione wartości
      _minController.text = '$_minValue';
      _maxController.text = '$_maxValue';

      // Generowanie liczby w poprawionym zakresie
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
        title: const Text(
          'Generator Liczb',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
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
                      builder: (context) => const PasswordScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Generuj hasło',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: SelectableText(
                  _randomNumber != null ? '$_randomNumber' : '0',
                  style: const TextStyle(fontSize: 84, fontWeight: FontWeight.bold),
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
                        const Text("Tylko parzyste", style: TextStyle(fontSize: 20)),
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
                        const Text("Tylko nieparzyste", style: TextStyle(fontSize: 20)),
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
                const SizedBox(height: 10),
                const Text("Zakres liczb:", style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _minController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Min",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        controller: _maxController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Max",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateRandomNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontSize: 24),
                ),
                child: const Text(
                  'Generuj',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
