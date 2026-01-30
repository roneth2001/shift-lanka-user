import 'package:flutter/material.dart';
import 'package:shoftlanka_driver/constansts/app_constants.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              AppStrings.mySchedule,
              style: AppTextStyles.heading2,
            ),
            Text(
              'Friday, January 30, 2026',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // Today's Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: AppDecorations.gradientCardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.todaySummary,
                    style: AppTextStyles.whiteLarge,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('5', AppStrings.totalRides),
                      _buildSummaryItem('2', AppStrings.completed),
                      _buildSummaryItem('3', AppStrings.upcoming),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Ride Schedule Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.rideSchedule,
                style: AppTextStyles.heading2,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Ride Cards
            _buildRideCard(
              context,
              route: 'Route 42 - Downtown Loop',
              time: '08:00 AM - 09:30 AM',
              stops: '12 ${AppStrings.stops}',
              status: AppStrings.completed,
              statusColor: AppColors.successGreen,
              statusBgColor: AppColors.successGreenBg,
            ),
            const SizedBox(height: AppSpacing.md),
            
            _buildRideCard(
              context,
              route: 'Route 15 - East Side Express',
              time: '10:00 AM - 11:45 AM',
              stops: '18 ${AppStrings.stops}',
              status: AppStrings.completed,
              statusColor: AppColors.successGreen,
              statusBgColor: AppColors.successGreenBg,
            ),
            const SizedBox(height: AppSpacing.md),
            
            _buildRideCard(
              context,
              route: 'Route 8 - North Terminal',
              time: '01:00 PM - 02:15 PM',
              stops: '10 ${AppStrings.stops}',
              status: AppStrings.upcoming,
              statusColor: AppColors.infoBlue,
              statusBgColor: AppColors.infoBlueBg,
              showDetails: true,
            ),
            const SizedBox(height: AppSpacing.md),
            
            _buildRideCard(
              context,
              route: 'Route 23 - South Station',
              time: '03:00 PM - 04:30 PM',
              stops: '15 ${AppStrings.stops}',
              status: AppStrings.upcoming,
              statusColor: AppColors.infoBlue,
              statusBgColor: AppColors.infoBlueBg,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.displayMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.whiteCaption,
        ),
      ],
    );
  }

  Widget _buildRideCard(
    BuildContext context, {
    required String route,
    required String time,
    required String stops,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
    bool showDetails = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: AppDecorations.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  route,
                  style: AppTextStyles.heading3,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: AppDecorations.statusBadgeDecoration(statusBgColor),
                child: Text(
                  status,
                  style: AppTextStyles.statusBadge(statusColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: AppIconSize.small,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                time,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: AppIconSize.small,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    stops,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              if (showDetails)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: const [
                      Text(
                        AppStrings.viewDetails,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.infoBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.arrow_forward,
                        size: AppIconSize.small,
                        color: AppColors.infoBlue,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}