import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void _navigateToLoginView(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToLoginView(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.appLogo,
            ),
            SizedBox(height: AppPadding.verticalPaddingL),
            Text(
              'SIMS PPOB',
              style: AppTextStyles.titleTextStyle,
            ),
            SizedBox(height: AppPadding.verticalPaddingL),
            Text(
              'Dede Risman',
              style: AppTextStyles.descriptionTextStyle
                  .copyWith(color: AppColors.hintTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
