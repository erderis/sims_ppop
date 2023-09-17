import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_confirm_visibility_provider.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_visibility_provider.dart';
import 'package:simsppob/utils/helper/email_validator.dart';

class RegisterFormView extends StatefulWidget {
  const RegisterFormView({super.key});

  @override
  State<RegisterFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<RegisterFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  void onRegister(BuildContext context) {
    // Navigator.pushNamedAndRemoveUntil(context, Routes.main, (routes) => false);

    if (formKey.currentState?.validate() == true) {
      // Implement your login logic here
      // Access emailController.text and passwordController.text to get the entered email and password
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
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
            AppTextField(
              controller: _firstNameController,
              hintText: 'nama depan',
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'nama depan tidak boleh kosong';
                }
                return null;
              },
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: AppPadding.verticalPaddingM * 2),
            AppTextField(
              controller: _lastNameController,
              hintText: 'nama belakang',
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'nama belakang tidak boleh kosong';
                }
                return null;
              },
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: AppPadding.verticalPaddingM * 2),
            Consumer<RegisterPasswordVisibilityProvider>(
              builder: (context, provider, _) {
                return AppTextField(
                  controller: _passwordController,
                  hintText: 'buat password',
                  isPassword: true,
                  isPasswordVisible: provider.visibility,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password tidak boleh kosong';
                    } else if (_passwordConfirmController.text.length < 8) {
                      return 'password tidak boleh kurang dari 8 karakter';
                    }
                    return null;
                  },
                  togglePasswordVisibility: () {
                    context
                        .read<RegisterPasswordVisibilityProvider>()
                        .setVisibility(!provider.visibility);
                  },
                  prefixIcon: Icons.lock_outline,
                );
              },
            ),
            SizedBox(height: AppPadding.verticalPaddingM * 2),
            Consumer<RegisterPasswordConfirmVisibilityProvider>(
              builder: (context, provider, _) {
                return AppTextField(
                  controller: _passwordConfirmController,
                  hintText: 'konfirmasi password',
                  isPassword: true,
                  isPasswordVisible: provider.visibility,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password tidak boleh kosong';
                    } else if (_passwordController.text !=
                        _passwordConfirmController.text) {
                      return 'password tidak sama';
                    }
                    return null;
                  },
                  togglePasswordVisibility: () {
                    context
                        .read<RegisterPasswordConfirmVisibilityProvider>()
                        .setVisibility(!provider.visibility);
                  },
                  prefixIcon: Icons.lock_outline,
                );
              },
            ),
            SizedBox(height: AppPadding.verticalPaddingM * 2),
            AppButton(
              text: 'Registrasi',
              onPressed: () => onRegister(context),
            ),
          ],
        ),
      ),
    );
  }
}
