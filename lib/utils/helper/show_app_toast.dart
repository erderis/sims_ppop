import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

Flushbar?
    _currentFlushbar; // Variable to store the currently displayed Flushbar.

void showAppToast(BuildContext context, {required String message}) {
  _currentFlushbar?.dismiss(); // Dismiss any existing Flushbar.

  _currentFlushbar = Flushbar(
    messageText: Text(
      message,
      style: AppTextStyles.descriptionTextStyle
          .copyWith(fontSize: 12.sp, color: AppColors.accentColor),
    ),
    mainButton: IconButton(
      onPressed: () {
        _currentFlushbar?.dismiss(); // Dismiss the current Flushbar.
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
    backgroundColor: AppColors.toastColor,
  );

  _currentFlushbar?.show(context);
}
