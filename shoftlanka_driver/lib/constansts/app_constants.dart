import 'package:flutter/material.dart';

// App Colors
class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color backgroundGray = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF374151);
  
  // Status Colors
  static const Color successGreen = Color(0xFF10B981);
  static const Color successGreenBg = Color(0xFFD1FAE5);
  static const Color warningYellow = Color(0xFFF59E0B);
  static const Color warningYellowBg = Color(0xFFFEF3C7);
  static const Color infoBlue = Color(0xFF3B82F6);
  static const Color infoBlueBg = Color(0xFFDBEAFE);
  
  // UI Colors
  static const Color borderGray = Color(0xFFE5E7EB);
  static const Color circleIconBg = Color(0xFFBFDBFE);
  static const Color dividerGray = Color(0xFFE5E7EB);
  
  // Gradient Colors
  static const List<Color> blueGradient = [lightBlue, primaryBlue];
}

// Text Styles
class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  
  // Special Text Styles
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );
  
  static const TextStyle hintText = TextStyle(
    color: AppColors.textTertiary,
  );
  
  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  static const TextStyle linkText = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 14,
  );
  
  // Display Text (Large numbers, time, etc.)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  
  static const TextStyle statNumber = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.lightBlue,
  );
  
  static const TextStyle statNumberGreen = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.successGreen,
  );
  
  // Status Badge Text
  static TextStyle statusBadge(Color color) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: color,
  );
  
  // White Text Variants
  static const TextStyle whiteTitle = TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );
  
  static const TextStyle whiteLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  static const TextStyle whiteBody = TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );
  
  static const TextStyle whiteCaption = TextStyle(
    fontSize: 13,
    color: Colors.white70,
  );
}

// App Spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
}

// Border Radius
class AppRadius {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;
  static const double circle = 50.0;
}

// Icon Sizes
class AppIconSize {
  static const double small = 16.0;
  static const double medium = 28.0;
  static const double large = 32.0;
  static const double extraLarge = 40.0;
}

// Common Decorations
class AppDecorations {
  // Card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(AppRadius.medium),
  );
  
  // Gradient card decoration
  static BoxDecoration gradientCardDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: AppColors.blueGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(AppRadius.large),
  );
  
  // Input field decoration
  static InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.hintText,
      prefixIcon: Icon(icon, color: AppColors.textTertiary),
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: const BorderSide(color: AppColors.borderGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: const BorderSide(color: AppColors.borderGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
    );
  }
  
  // Button style
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.small),
    ),
  );
  
  // Status badge decoration
  static BoxDecoration statusBadgeDecoration(Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.small),
    );
  }
  
  // Icon container decoration
  static BoxDecoration iconContainerDecoration(Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.small),
    );
  }
  
  // Circle avatar decoration
  static BoxDecoration circleAvatarDecoration = const BoxDecoration(
    color: AppColors.circleIconBg,
    shape: BoxShape.circle,
  );
}

// App Strings
class AppStrings {
  // App Info
  static const String appName = 'ShiftLanka';
  static const String appSubtitle = 'Driver Portal';
  static const String copyright = '© 2026 ShiftLanka';
  
  // Login Screen
  static const String username = 'Username';
  static const String password = 'Password';
  static const String usernameHint = 'Enter your username';
  static const String passwordHint = 'Enter your password';
  static const String signIn = 'Sign In';
  static const String forgotPassword = 'Forgot your password?';
  
  // Dashboard Screen
  static const String currentTime = 'Current Time';
  static const String startRide = 'Start Ride';
  static const String startRideDesc = 'Begin your next scheduled route';
  static const String reportWarning = 'Report Warning';
  static const String reportWarningDesc = 'Report incidents or issues';
  static const String viewSchedule = 'View Schedule';
  static const String viewScheduleDesc = 'Check your upcoming rides';
  static const String quickStats = 'Quick Stats';
  static const String thisWeek = 'This Week';
  static const String onTime = 'On Time';
  
  // Schedule Screen
  static const String mySchedule = 'My Schedule';
  static const String todaySummary = "Today's Summary";
  static const String totalRides = 'Total Rides';
  static const String completed = 'Completed';
  static const String upcoming = 'Upcoming';
  static const String rideSchedule = 'Ride Schedule';
  static const String stops = 'stops';
  static const String viewDetails = 'View Details';
}