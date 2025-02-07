import 'package:flutter/material.dart';

class BodyLanguageAnalysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Language Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posture',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CharacteristicTile(
              characteristic: 'Slouching/Posture',
              analysisMethod: 'Angle between shoulders and hips',
              accuracy: '85-90%',
            ),
            CharacteristicTile(
              characteristic: 'Shoulder Alignment',
              analysisMethod: 'Y-coordinates of left/right shoulders',
              accuracy: '90%',
            ),
            SizedBox(height: 20),
            Text(
              'Movement',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CharacteristicTile(
              characteristic: 'Hand Gestures',
              analysisMethod: 'Wrist landmarks relative to body midline',
              accuracy: '80-85%',
            ),
            CharacteristicTile(
              characteristic: 'Fidgeting (e.g., swaying)',
              analysisMethod: 'Speed of wrist/elbow movement',
              accuracy: '70-75%',
            ),
            SizedBox(height: 20),
            Text(
              'Facial',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CharacteristicTile(
              characteristic: 'Eye Contact',
              analysisMethod: 'Facial landmarks (eyes, nose)',
              accuracy: '75-80%',
            ),
          ],
        ),
      ),
    );
  }
}

class CharacteristicTile extends StatelessWidget {
  final String characteristic;
  final String analysisMethod;
  final String accuracy;

  const CharacteristicTile({
    Key? key,
    required this.characteristic,
    required this.analysisMethod,
    required this.accuracy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              characteristic,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Analysis Method: $analysisMethod'),
            Text('Accuracy: $accuracy'),
          ],
        ),
      ),
    );
  }
}