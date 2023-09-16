import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/features/login/presentation/cubit/login_password_visibility_cubit.dart';
import 'package:simsppob/utils/helper/email_validator.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onLogin(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      // Implement your login logic here
      // Access emailController.text and passwordController.text to get the entered email and password
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.main, (routes) => false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
        child: Column(
          children: [
            AppTextField(
              controller: _emailController,
              hintText: 'masukkan email anda',
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'email tidak boleh kosong';
                } else if (!isValidEmail(value)) {
                  return 'alamat email tidak valid';
                }
                return null;
              },
              prefixIcon: Icons.alternate_email,
            ),
            SizedBox(height: AppPadding.verticalPaddingM * 2),
            BlocBuilder<LoginPasswordVisibilityCubit, bool>(
              builder: (context, isPasswordVisible) {
                return AppTextField(
                  controller: _passwordController,
                  hintText: 'masukkan password anda',
                  isPassword: true,
                  isPasswordVisible: isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password tidak boleh kosong';
                    }
                    return null;
                  },
                  togglePasswordVisibility: () {
                    context
                        .read<LoginPasswordVisibilityCubit>()
                        .setVisibility(!isPasswordVisible);
                  },
                  prefixIcon: Icons.lock_outline,
                );
              },
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            AppButton(
              text: 'Masuk',
              onPressed: () => onLogin(context),
            ),
          ],
        ),
      ),
    );
  }
}
