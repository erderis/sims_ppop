import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AuthFooterView extends StatelessWidget {
  const AuthFooterView({
    super.key,
    required this.title,
    required this.route,
  });

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Visibility(
        visible: !isKeyboardVisible,
        child: RichText(
            text: TextSpan(
                style: AppTextStyles.descriptionTextStyle
                    .copyWith(color: AppColors.textColorSecondary),
                children: [
              TextSpan(text: title),
              TextSpan(
                text: 'di sini',
                style: AppTextStyles.descriptionTextStyle.copyWith(
                    color: AppColors.accentColor, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, route),
              ),
            ])),
      );
    });
  }
}
