import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shiftlanka_user/screens/pages/profile_details.dart';
import 'firebase_options.dart';
import 'package:shiftlanka_user/screens/auth/Loging_screen.dart';
import 'package:shiftlanka_user/screens/auth/signup.dart';
import 'package:shiftlanka_user/screens/home.dart';
import 'package:shiftlanka_user/screens/loading/SplashScreen.dart';
import 'package:shiftlanka_user/screens/pages/route_search.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If Firebase is already initialized, continue
    if (e.toString().contains('duplicate-app')) {
      debugPrint('Firebase already initialized');
    } else {
      // Log other errors but don't crash
      debugPrint('Firebase initialization error: $e');
    }
  }
  
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
      initialRoute: '/splash',
      routes: {
        '/splash' : (context) => const SplashScreen(),
        '/login'  : (context) => const LoginScreen(),
        '/signup' : (context) => const SignUpScreen(),
        '/home'   : (context) => const ShiftLankaAppHome(),
        '/routes'  : (context) => const RouteSearch(),
        '/account' : (context) => const AccountDetailsPage(),
      },
    );
  }
}