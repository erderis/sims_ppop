import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AuthHeaderView extends StatelessWidget {
  const AuthHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
