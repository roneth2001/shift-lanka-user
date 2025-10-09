import 'package:flutter/material.dart';
import 'package:shiftlanka_user/screens/home.dart';

void main() {
  runApp(const ShiftLankaApp());
}

class ShiftLankaApp extends StatelessWidget {
  const ShiftLankaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHIFT LANKA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
