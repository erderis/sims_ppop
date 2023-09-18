import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/last_login_provider.dart';

class AccountErrorView extends StatelessWidget {
  const AccountErrorView({
    super.key,
    required this.messsage,
  });

  final String messsage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              messsage,
              style: AppTextStyles.descriptionTextStyle,
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL,
            ),
            AppButton(
                text: 'Logout',
                onPressed: () {
                  context.read<LastLoginProvider>().logout().then((value) =>
                      Navigator.pushReplacementNamed(context, Routes.login));
                }),
          ],
        ),
      ),
    );
  }
}
