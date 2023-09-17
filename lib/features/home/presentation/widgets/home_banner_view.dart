import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';
import 'package:simsppob/features/home/presentation/provider/banner_provider.dart';

class HomeBannerView extends StatelessWidget {
  const HomeBannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(builder: (context, provider, _) {
      if (provider.dataState.isLoading) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
          child: const AppShimmer(
            height: 120,
            width: double.infinity,
          ),
        );
      } else if (provider.dataState.isSuccess) {
        final data = provider.dataState.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.horizontalPaddingXL),
              child: Text(
                'Temukan promo menarik',
                style: AppTextStyles.subTitleTextStyle
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: AppPadding.verticalPaddingXL / 2,
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.horizontalPaddingXL),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: index == data.length - 1 ? 0 : 8.w),
                  child: SizedBox(
                    height: 119,
                    width: 270,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius:
                              BorderRadius.circular(AppPadding.radius * 2),
                          image: DecorationImage(
                              image: NetworkImage(data[index].bannerImage))),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
