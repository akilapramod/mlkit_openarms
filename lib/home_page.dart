// screens/home_page.dart
import 'package:flutter/material.dart';
import 'camera_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ML Kit Painter Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Start Camera'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/body-language');
              },
              child: Text('Body Language Analysis'),
            ),
          ],
        ),
      ),
    );
  }
}