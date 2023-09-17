import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';

class AppDialogLoading extends StatelessWidget {
  const AppDialogLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: AppColors.backgroundColor,
        insetPadding: EdgeInsets.all(AppPadding.horizontalPaddingXL),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.radius * 2)),
        child: SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight * 0.3,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.accentColor,
            ),
          ),
        ));
  }
}
