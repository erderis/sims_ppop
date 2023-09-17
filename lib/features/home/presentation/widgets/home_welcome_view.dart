import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';

class HomeWelcomeView extends StatelessWidget {
  const HomeWelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
      child: Consumer<ProfileProvider>(builder: (context, provider, _) {
        if (provider.dataState.isLoading) {
          return const AppShimmer(
            height: 100,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang,',
              style: AppTextStyles.subTitleTextStyle
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: AppPadding.verticalPaddingS / 2,
            ),
            Text(
              provider.dataState.isSuccess
                  ? '${provider.dataState.data?.firstName} ${provider.dataState.data?.lastName}'
                  : '',
              style: AppTextStyles.titleTextStyle,
            ),
          ],
        );
      }),
    );
  }
}
