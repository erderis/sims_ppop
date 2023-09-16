import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart'; // Import the AppColors class or replace with the actual file path if different

class AppTextStyles {
  static final TextStyle titleTextStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
  static final TextStyle subTitleTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static final TextStyle descriptionTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static final TextStyle subDescriptionTextStyle = TextStyle(
    fontSize: 10.sp,
    color: AppColors.textColor,
  );

  static final TextStyle buttonTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorLight,
  );
}
