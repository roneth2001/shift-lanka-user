import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryPurple = Color(0xFF4A148C);
  static const Color deepPurple = Color(0xFF311B92);
  static const Color backgroundPurple = Color(0xFF5E35B1);
  
  // Accent Colors
  static const Color vibrantOrange = Color(0xFFFF5722);
  static const Color brightOrange = Color(0xFFFF6F3C);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFB8B3C8);
  static const Color inputGray = Color(0xFF7E73A3);
  static const Color textGray = Color(0xFFE0E0E0);
  
  // Dark Colors
  static const Color darkPurple = Color(0xFF2D1B4E);
  static const Color iconDark = Color(0xFF3D2E52);
  
  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryPurple,
      deepPurple,
      backgroundPurple,
    ],
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      vibrantOrange,
      brightOrange,
    ],
  );
}