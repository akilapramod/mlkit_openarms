import 'package:flutter/material.dart';

class BodyLanguagePage extends StatelessWidget {
  const BodyLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Language Analysis'),
      ),
      body: const Center(
        child: Text(
          'This page will display detailed body language analysis.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}