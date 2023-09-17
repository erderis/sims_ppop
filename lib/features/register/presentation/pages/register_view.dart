import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_confirm_visibility_provider.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_visibility_provider.dart';
import 'package:simsppob/features/register/presentation/widgets/register_form_view.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
              Row(
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
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: AppTextStyles.descriptionTextStyle
                          .copyWith(color: AppColors.textColorSecondary),
                      children: [
                        const TextSpan(text: 'Sudah punya akun? login '),
                        TextSpan(
                          text: 'di sini',
                          style: AppTextStyles.descriptionTextStyle.copyWith(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, Routes.login),
                        ),
                      ])),
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
