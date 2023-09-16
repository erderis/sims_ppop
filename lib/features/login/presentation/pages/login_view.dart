import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/features/login/presentation/provider/login_provider.dart';
import 'package:simsppob/features/login/presentation/widgets/login_form_view.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<LoginProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<LoginPasswordVisibilityProvider>(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                  return Visibility(
                    visible: !isKeyboardVisible,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.appLogo,
                          width: 32.w,
                        ),
                        SizedBox(
                          width: AppPadding.horizontalPaddingS,
                        ),
                        Text(
                          'SIMS PPOB',
                          style: AppTextStyles.titleTextStyle,
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                Text(
                  'Masuk atau buat akun\nuntuk memulai',
                  style: AppTextStyles.titleTextStyle.copyWith(fontSize: 30.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingL * 3,
                ),
                //field
                const LoginFormView(),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                RichText(
                    text: TextSpan(
                        style: AppTextStyles.descriptionTextStyle
                            .copyWith(color: AppColors.textColorSecondary),
                        children: [
                      const TextSpan(text: 'Belum punya akun? registrasi '),
                      TextSpan(
                        text: 'di sini',
                        style: AppTextStyles.descriptionTextStyle.copyWith(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.pushNamed(context, Routes.register),
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
