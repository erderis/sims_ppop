import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AppDialogNotif extends StatelessWidget {
  const AppDialogNotif({
    super.key,
    required this.isSuccess,
    required this.value,
    this.title = '',
    this.isRegister = false,
    this.textButton,
    this.onConfirm,
  });

  final bool isSuccess;
  final bool isRegister;
  final String title;
  final String value;
  final String? textButton;
  final VoidCallback? onConfirm;

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
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                    color: isSuccess ? AppColors.success : AppColors.failed,
                    shape: BoxShape.circle),
                child: Icon(
                  isSuccess ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(
                height: AppPadding.verticalPaddingXL,
              ),
              Visibility(
                visible: !isRegister,
                child: Text(
                  title,
                  style: AppTextStyles.descriptionTextStyle
                      .copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: AppPadding.verticalPaddingS,
              ),
              Text(
                value,
                style: AppTextStyles.titleTextStyle,
              ),
              SizedBox(
                height: AppPadding.verticalPaddingS,
              ),
              Text(
                isSuccess ? 'berhasil!' : 'Gagal',
                style: AppTextStyles.descriptionTextStyle
                    .copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: AppPadding.verticalPaddingXL,
              ),
              TextButton(
                onPressed: onConfirm ??
                    () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                child: Text(
                  textButton ?? 'Kembali ke Beranda',
                  style: AppTextStyles.descriptionTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentColor),
                ),
              ),
              SizedBox(
                height: AppPadding.verticalPaddingXL,
              ),
            ],
          ),
        ));
  }
}
