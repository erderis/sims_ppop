import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class SaldoItemView extends StatelessWidget {
  const SaldoItemView({
    super.key,
    required this.amount,
    this.isHome = false,
  });

  final String amount;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isHome
            ? SvgPicture.asset(AppAssets.backgroundSaldo)
            : ClipRRect(
                borderRadius: BorderRadius.circular(AppPadding.radius * 3),
                child: SizedBox(
                  height: 122.h,
                  width: ScreenUtil().screenWidth,
                  child: SvgPicture.asset(
                    AppAssets.backgroundSaldo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Container(
          height: isHome ? 153.h : 122.h,
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.horizontalPaddingXL,
              vertical: AppPadding.verticalPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'Saldo Anda',
                style: AppTextStyles.descriptionTextStyle
                    .copyWith(color: AppColors.textColorLight, fontSize: 16.sp),
              ),
              const Spacer(),
              Text(
                amount,
                style: AppTextStyles.titleTextStyle.copyWith(
                    color: AppColors.textColorLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.sp),
              ),
              const Spacer(),
              Visibility(
                visible: isHome,
                child: Row(
                  children: [
                    Text(
                      'Lihat Saldo',
                      style: AppTextStyles.descriptionTextStyle.copyWith(
                        color: AppColors.textColorLight,
                      ),
                    ),
                    SizedBox(
                      width: AppPadding.horizontalPaddingS / 2,
                    ),
                    SvgPicture.asset(
                      AppAssets.eyeOff,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
