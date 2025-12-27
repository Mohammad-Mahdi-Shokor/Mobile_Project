import 'package:flutter/material.dart';

import 'learning_screen.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LearningScreen(), // opens HomeScreen by default
    );
  }
}