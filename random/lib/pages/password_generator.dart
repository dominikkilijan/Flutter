import 'dart:math';
import 'package:flutter/material.dart';
import 'random_number_generator.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  PasswordScreenState createState() => PasswordScreenState();
}

class PasswordScreenState extends State<PasswordScreen> {
  String? _password;
  int _passwordLength = 10;

  final TextEditingController _passwordLengthController = TextEditingController();

  final Map<String, bool> _options = {
    'uppercase': true,
    'lowercase': true,
    'numbers': true,
    'special': true,
  };

  @override
  void initState() {
    super.initState();
    _passwordLengthController.text = '$_passwordLength';
  }

  @override
  void dispose() {
    _passwordLengthController.dispose();
    super.dispose();
  }

  String _generatePassword() {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const special = '!@#\$%^&*()';
    String chars = '';

    if (_options['uppercase']!) chars += uppercase;
    if (_options['lowercase']!) chars += lowercase;
    if (_options['numbers']!) chars += numbers;
    if (_options['special']!) chars += special;

    return List.generate(
      _passwordLength,
          (_) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  void _generateNewPassword() {
    setState(() {
      _password = _generatePassword();
    });
  }

  void _toggleSwitch(String type) {
    setState(() {
      _options[type] = !_options[type]!;

      if (_options.values.every((value) => !value)) {
        _options[type] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Generator Hasła",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
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
                      builder: (context) => const RandomNumberGenerator(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Generuj liczbę',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: SelectableText(
                  _password ?? 'Haslo123',
                  style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Długość hasła:", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _passwordLengthController,
                        onChanged: (value) {
                          setState(() {
                            _passwordLength = int.tryParse(value) ?? 10;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Długość',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildSwitch("Liczby", 'numbers'),
                _buildSwitch("Małe litery", 'lowercase'),
                _buildSwitch("Wielkie litery", 'uppercase'),
                _buildSwitch("Znaki specjalne", 'special'),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateNewPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
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

  Widget _buildSwitch(String label, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 20)),
        Switch(
          value: _options[type]!,
          onChanged: (_) => _toggleSwitch(type),
          activeColor: Colors.brown,
        ),
      ],
    );
  }
}
