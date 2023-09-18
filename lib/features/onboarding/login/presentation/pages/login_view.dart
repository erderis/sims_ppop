import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/widgets/auth_footer_view.dart';
import 'package:simsppob/features/onboarding/login/presentation/widgets/login_form_view.dart';
import 'package:simsppob/features/onboarding/login/presentation/widgets/auth_header_view.dart';
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
                      child: const AuthHeaderView());
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
                const LoginFormView(),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                const AuthFooterView(
                  title: 'Belum punya akun? registrasi ',
                  route: Routes.register,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
