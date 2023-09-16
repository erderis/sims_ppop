import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leadingWidth: 120.w,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(title,
          style: AppTextStyles.subTitleTextStyle.copyWith(fontSize: 16.sp)),
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            SizedBox(
              width: AppPadding.horizontalPaddingXL,
            ),
            InkWell(
              onTap: onBack,
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: AppColors.textColor,
                  ),
                  SizedBox(
                    width: AppPadding.horizontalPaddingS / 2,
                  ),
                  Text(
                    'Kembali',
                    style: AppTextStyles.descriptionTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
