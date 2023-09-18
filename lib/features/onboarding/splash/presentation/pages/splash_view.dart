import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/last_login_provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void _navigateToLoginView(BuildContext context, {required bool isLoggedIn}) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(
          context, isLoggedIn ? Routes.main : Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LastLoginProvider>(builder: (context, provider, _) {
      if (!provider.dataState.isLoading) {
        _navigateToLoginView(context, isLoggedIn: provider.dataState.isSuccess);
      }
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
    });
  }
}
