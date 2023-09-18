import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/onboarding/login/presentation/widgets/auth_footer_view.dart';
import 'package:simsppob/features/onboarding/login/presentation/widgets/auth_header_view.dart';
import 'package:simsppob/features/onboarding/register/presentation/provider/register_password_confirm_visibility_provider.dart';
import 'package:simsppob/features/onboarding/register/presentation/provider/register_password_visibility_provider.dart';
import 'package:simsppob/features/onboarding/register/presentation/provider/register_provider.dart';
import 'package:simsppob/features/onboarding/register/presentation/widgets/register_form_view.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<RegisterProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<RegisterPasswordVisibilityProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<RegisterPasswordConfirmVisibilityProvider>(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: AppPadding.verticalPaddingL,
              ),
              const AuthHeaderView(),
              SizedBox(
                height: AppPadding.verticalPaddingM * 2,
              ),
              Text(
                'Lengkapi Data Untuk\nMembuat Akun',
                style: AppTextStyles.titleTextStyle.copyWith(fontSize: 30.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppPadding.verticalPaddingL * 3,
              ),
              const RegisterFormView(),
              SizedBox(
                height: AppPadding.verticalPaddingM * 2,
              ),
              const AuthFooterView(
                title: 'Sudah punya akun? login ',
                route: Routes.login,
              ),
              SizedBox(
                height: AppPadding.verticalPaddingM * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
