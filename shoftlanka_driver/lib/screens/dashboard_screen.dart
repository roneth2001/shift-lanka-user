import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoftlanka_driver/constansts/app_constants.dart';
import 'schedule_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String currentTime;
  late String currentDate;

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update time every second
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _updateTime();
        });
        _startTimer();
      }
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    currentTime = DateFormat('hh:mm a').format(now);
    currentDate = DateFormat('EEEE, MMMM d, y').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: CircleAvatar(
            backgroundColor: AppColors.circleIconBg,
            child: const Icon(
              Icons.person,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'John Driver',
              style: AppTextStyles.heading3,
            ),
            Text(
              'Driver ID: #12345',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // Current Time Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: AppDecorations.gradientCardDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.currentTime,
                        style: AppTextStyles.whiteTitle,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        currentTime,
                        style: AppTextStyles.displayLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        currentDate,
                        style: AppTextStyles.whiteTitle,
                      ),
                    ],
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.access_time,
                      size: AppIconSize.large,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Action Cards
            _buildActionCard(
              context,
              icon: Icons.play_arrow,
              title: AppStrings.startRide,
              subtitle: AppStrings.startRideDesc,
              color: AppColors.successGreenBg,
              iconColor: AppColors.successGreen,
            ),
            const SizedBox(height: AppSpacing.md),
            
            _buildActionCard(
              context,
              icon: Icons.warning_amber_rounded,
              title: AppStrings.reportWarning,
              subtitle: AppStrings.reportWarningDesc,
              color: AppColors.warningYellowBg,
              iconColor: AppColors.warningYellow,
            ),
            const SizedBox(height: AppSpacing.md),
            
            _buildActionCard(
              context,
              icon: Icons.calendar_today,
              title: AppStrings.viewSchedule,
              subtitle: AppStrings.viewScheduleDesc,
              color: AppColors.infoBlueBg,
              iconColor: AppColors.infoBlue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduleScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Quick Stats
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: AppDecorations.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.quickStats,
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Text(
                              '24',
                              style: AppTextStyles.statNumber,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              AppStrings.thisWeek,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: AppColors.dividerGray,
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text(
                              '98%',
                              style: AppTextStyles.statNumberGreen,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              AppStrings.onTime,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: AppDecorations.cardDecoration,
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: AppDecorations.iconContainerDecoration(color),
              child: Icon(
                icon,
                size: AppIconSize.medium,
                color: iconColor,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}