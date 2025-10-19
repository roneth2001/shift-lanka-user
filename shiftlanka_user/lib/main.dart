import 'dart:math' as math;
import 'package:flutter/material.dart';

// Your existing screens
import 'package:shiftlanka_user/screens/auth/Loging_screen.dart';
import 'package:shiftlanka_user/screens/auth/signup.dart';
import 'package:shiftlanka_user/screens/home.dart';
import 'package:shiftlanka_user/screens/loading/SplashScreen.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E2C90)),
      ),
      // Start from splash instead of login
      initialRoute: '/home',
      routes: {
        '/splash' : (context) => const SplashScreen(),
        '/login'  : (context) => const LoginScreen(),
        '/signup' : (context) => const SignUpScreen(),
        '/home'   : (context) => const ShiftLankaAppHome(),
      },
    );
  }
}