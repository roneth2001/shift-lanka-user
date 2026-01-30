import 'package:flutter/material.dart';
import 'package:shoftlanka_driver/constansts/app_constants.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ShiftLankaApp());
}

class ShiftLankaApp extends StatelessWidget {
  const ShiftLankaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.backgroundGray,
        fontFamily: 'Segoe UI',
      ),
      home: const LoginScreen(),
    );
  }
}