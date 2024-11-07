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
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSpecialCharacters = true;

  final TextEditingController _passwordLengthController = TextEditingController();

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

    if (_includeUppercase) chars += uppercase;
    if (_includeLowercase) chars += lowercase;
    if (_includeNumbers) chars += numbers;
    if (_includeSpecialCharacters) chars += special;

    return List.generate(
      _passwordLength,
          (index) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  void _generateNewPassword() {
    setState(() {
      _password = _generatePassword();
    });
  }

  void _toggleSwitch(bool value, String type) {
    setState(() {
      switch (type) {
        case 'uppercase':
          _includeUppercase = value;
          break;
        case 'lowercase':
          _includeLowercase = value;
          break;
        case 'numbers':
          _includeNumbers = value;
          break;
        case 'special':
          _includeSpecialCharacters = value;
          break;
      }

      if (!(_includeUppercase || _includeLowercase || _includeNumbers || _includeSpecialCharacters)) {
        switch (type) {
          case 'uppercase':
            _includeUppercase = true;
            break;
          case 'lowercase':
            _includeLowercase = true;
            break;
          case 'numbers':
            _includeNumbers = true;
            break;
          case 'special':
            _includeSpecialCharacters = true;
            break;
        }
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
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
                            _passwordLength = int.tryParse(value) ?? 12;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Liczby", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeNumbers,
                      onChanged: (value) => _toggleSwitch(value, 'numbers'),
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Małe litery", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeLowercase,
                      onChanged: (value) => _toggleSwitch(value, 'lowercase'),
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Wielkie litery", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeUppercase,
                      onChanged: (value) => _toggleSwitch(value, 'uppercase'),
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Znaki specjalne", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeSpecialCharacters,
                      onChanged: (value) => _toggleSwitch(value, 'special'),
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
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
}
