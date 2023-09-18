import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/onboarding/login/data/models/login_model.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_provider.dart';
import 'package:simsppob/utils/helper/email_validator.dart';
import 'package:simsppob/utils/helper/reload_all_state.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onLogin(BuildContext context, LoginProvider provider) {
    if (formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      provider
          .login(LoginModel(
              email: _emailController.text, password: _passwordController.text))
          .then((value) {
        if (provider.dataState.isSuccess) {
          final balanceProvider =
              Provider.of<BalanceProvider>(context, listen: false);
          if (balanceProvider.dataState.isSuccess) {
            reloadAllState(context);
          }
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.main, (routes) => false);
        }
        if (provider.dataState.isError) {
          showAppToast(context, message: provider.dataState.error!);
        }
      });
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
            Consumer<LoginPasswordVisibilityProvider>(
              builder: (context, provider, _) {
                return AppTextField(
                  controller: _passwordController,
                  hintText: 'masukkan password anda',
                  isPassword: true,
                  isPasswordVisible: provider.visibility,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password tidak boleh kosong';
                    } else if (value.length < 8) {
                      return 'password tidak boleh kurang dari 8 karakter';
                    }
                    return null;
                  },
                  togglePasswordVisibility: () {
                    context
                        .read<LoginPasswordVisibilityProvider>()
                        .setVisibility(!provider.visibility);
                  },
                  prefixIcon: Icons.lock_outline,
                );
              },
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            Consumer<LoginProvider>(builder: (context, provider, child) {
              return AppButton(
                text: 'Masuk',
                isLoading: provider.dataState.isLoading,
                onPressed: provider.dataState.isLoading
                    ? () {}
                    : () => onLogin(context, provider),
              );
            }),
          ],
        ),
      ),
    );
  }
}
