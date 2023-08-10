import 'package:flutter/material.dart';
import 'package:spin_and_win/screens/WheelScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6CA082)),
        useMaterial3: true,
      ),
      home: const WheelScreen(),
    );
  }
}
