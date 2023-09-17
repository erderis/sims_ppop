import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';

class AccountLoadingView extends StatelessWidget {
  const AccountLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.horizontalPaddingXL,
          vertical: AppPadding.verticalPaddingS),
      children: [
        const AppShimmer(
          height: 188,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingL * 2,
        ),
        const AppShimmer(
          height: 50,
          width: 200,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingL,
        ),
        ...List.generate(
            5,
            (index) => Column(
                  children: [
                    SizedBox(
                      height: AppPadding.verticalPaddingL,
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: const AppShimmer(),
                    ),
                  ],
                ))
      ],
    );
  }
}
