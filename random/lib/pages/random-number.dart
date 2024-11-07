import 'package:flutter/material.dart';

class RandomNumberPage extends StatelessWidget {
  const RandomNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number Generator'),
        centerTitle: true,
      ),
    );
  }
}
