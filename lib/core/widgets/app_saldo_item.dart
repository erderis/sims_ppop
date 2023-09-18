import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/home/presentation/provider/saldo_visibility_provider.dart';
import 'package:simsppob/utils/helper/format_currency.dart';

class AppSaldoItemView extends StatelessWidget {
  const AppSaldoItemView({
    super.key,
    this.isHome = false,
  });

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppPadding.radius * 3),
          child: SizedBox(
            height: isHome ? 153.h : 122.h,
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
              vertical: AppPadding.verticalPaddingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo Anda',
                style: AppTextStyles.descriptionTextStyle
                    .copyWith(color: AppColors.textColorLight, fontSize: 16.sp),
              ),
              Consumer<BalanceProvider>(builder: (context, provider, _) {
                final state = provider.dataState;
                return Consumer<SaldoVisibilityProvider>(
                    builder: (context, saldoProvider, _) {
                  if (state.isLoading) {
                    return const AppShimmer(
                      width: 250,
                    );
                  }
                  return Text(
                    state.isSuccess
                        ? saldoProvider.isVisible
                            ? formatCurrency(state.data!.balance)
                            : 'Rp${'•' * state.data!.balance.toString().length}'
                        : 'Rp',
                    style: AppTextStyles.titleTextStyle.copyWith(
                        color: AppColors.textColorLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp),
                  );
                });
              }),
              Visibility(
                visible: isHome,
                child: Consumer<SaldoVisibilityProvider>(
                    builder: (context, saldoProvider, _) {
                  return InkWell(
                    onTap: () => saldoProvider.toggleVisibility(),
                    child: Row(
                      children: [
                        Text(
                          'Lihat Saldo',
                          style: AppTextStyles.descriptionTextStyle.copyWith(
                            color: AppColors.textColorLight,
                          ),
                        ),
                        SizedBox(
                          width: AppPadding.horizontalPaddingS,
                        ),
                        InkWell(
                          onTap: () => saldoProvider.toggleVisibility(),
                          child: SvgPicture.asset(
                            saldoProvider.isVisible
                                ? AppAssets.eyeOff
                                : AppAssets.eye,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}
