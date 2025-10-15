import 'package:flutter/material.dart';
import 'package:shiftlanka_user/screens/auth/Loging_screen.dart';
import 'package:shiftlanka_user/screens/auth/signup.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const ShiftLankaAppHome(),
      },
    );
  }
}
