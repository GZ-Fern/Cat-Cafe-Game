import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const IdleGameProject());
}

class IdleGameProject extends StatelessWidget {
  const IdleGameProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Cafe Idle Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color.fromARGB(255, 60, 38, 46),
      ),
      home: const GamePage(),
    );
  }
}
