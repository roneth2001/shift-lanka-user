import 'package:flutter/material.dart';
import 'package:shoftlanka_driver/constansts/app_constants.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.extraLarge),
              ),
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: AppDecorations.circleAvatarDecoration,
                    child: const Icon(
                      Icons.directions_bus,
                      size: AppIconSize.extraLarge,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Title
                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    AppStrings.appSubtitle,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  
                  // Username Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.username,
                        style: AppTextStyles.label,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _usernameController,
                        decoration: AppDecorations.inputDecoration(
                          AppStrings.usernameHint,
                          Icons.person_outline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.password,
                        style: AppTextStyles.label,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: AppDecorations.inputDecoration(
                          AppStrings.passwordHint,
                          Icons.lock_outline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  
                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      },
                      style: AppDecorations.primaryButtonStyle,
                      child: Text(
                        AppStrings.signIn,
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Forgot Password
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppTextStyles.linkText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Copyright
                  Text(
                    AppStrings.copyright,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}