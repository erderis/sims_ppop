import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final bool isSecondary;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = AppColors.buttonColor,
    this.textColor = AppColors.buttonTextColor,
    this.isSecondary = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.all(16.w),
            backgroundColor: isSecondary ? textColor : buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppPadding.radius)),
            side: BorderSide(
                color: isSecondary ? buttonColor : Colors.transparent)),
        child: isLoading
            ? const SpinKitThreeBounce(
                size: 20,
                color: AppColors.backgroundColor,
              )
            : Text(
                text,
                style: AppTextStyles.buttonTextStyle
                    .copyWith(color: isSecondary ? buttonColor : textColor),
              ),
      ),
    );
  }
}
