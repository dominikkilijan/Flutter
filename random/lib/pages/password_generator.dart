import 'dart:math';
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String? _password;
  int _passwordLength = 12;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeSpecialCharacters = true;

  String _generatePassword() {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const special = '!@#\$%^&*()';
    String chars = '';

    if (_includeUppercase) chars += uppercase;
    if (_includeLowercase) chars += lowercase;
    chars += numbers;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Generator Hasła",
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.numbers),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Text(
                  _password ?? '',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Długość hasła:", style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: '$_passwordLength'),
                        onChanged: (value) {
                          setState(() {
                            _passwordLength = int.tryParse(value) ?? 12;
                          });
                        },
                        decoration: InputDecoration(
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
                    Text("Wielkie litery", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeUppercase,
                      onChanged: (value) {
                        setState(() {
                          _includeUppercase = value;
                        });
                      },
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Małe litery", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeLowercase,
                      onChanged: (value) {
                        setState(() {
                          _includeLowercase = value;
                        });
                      },
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Znaki specjalne", style: TextStyle(fontSize: 20)),
                    Switch(
                      value: _includeSpecialCharacters,
                      onChanged: (value) {
                        setState(() {
                          _includeSpecialCharacters = value;
                        });
                      },
                      activeColor: Colors.brown,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateNewPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
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
