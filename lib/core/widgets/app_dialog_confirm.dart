import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AppDialogConfirm extends StatelessWidget {
  final String title;
  final String amount;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const AppDialogConfirm({
    Key? key,
    required this.title,
    required this.amount,
    required this.confirmText,
    this.cancelText = 'Batalkan',
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      insetPadding: EdgeInsets.all(AppPadding.horizontalPaddingXL),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.radius * 2)),
      child: SizedBox(
        width: ScreenUtil().screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppPadding.verticalPaddingM * 2,
            ),
            SvgPicture.asset(
              AppAssets.appLogo,
              width: 64.w,
            ),
            SizedBox(
              height: AppPadding.verticalPaddingXL,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: AppTextStyles.descriptionTextStyle
                    .copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: AppPadding.verticalPaddingS,
            ),
            Text(
              '$amount ?',
              style: AppTextStyles.titleTextStyle,
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL,
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(
                confirmText,
                style: AppTextStyles.descriptionTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: AppPadding.verticalPaddingM,
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancelText,
                  style: AppTextStyles.descriptionTextStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.hintTextColor,
                  ),
                )),
            SizedBox(
              height: AppPadding.verticalPaddingM * 2,
            ),
          ],
        ),
      ),
    );
  }
}
