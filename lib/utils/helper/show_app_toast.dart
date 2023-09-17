import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

void showAppToast(BuildContext context, {required String message}) {
  Flushbar(
    messageText: Text(
      message,
      style: AppTextStyles.descriptionTextStyle
          .copyWith(fontSize: 12.sp, color: AppColors.accentColor),
    ),
    mainButton: IconButton(
      onPressed: () {
        // flush.dismiss();
      },
      icon: const Icon(
        Icons.close,
        color: AppColors.accentColor,
        size: 12,
      ),
    ),
    margin: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
    borderRadius: BorderRadius.circular(5.r),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.accentColor.withOpacity(0.05),
  ).show(context);
}
