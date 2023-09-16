import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 56),
        child: HomeHeaderView(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: AppPadding.verticalPaddingL,
          ),
          const HomeWelcomeView(),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.horizontalPaddingXL),
            child: const AppSaldoItemView(
              amount: 'Rp10.000',
              isHome: true,
            ),
          ),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
          const HomeServicesView(),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
          const HomeBannerView(),
          SizedBox(
            height: AppPadding.verticalPaddingXL,
          ),
        ],
      ),
    );
  }
}

class HomeBannerView extends StatelessWidget {
  const HomeBannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
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
          height: 120.h,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.horizontalPaddingXL),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: index == 2 ? 0 : 8.w),
              child: SizedBox(
                height: 120.h,
                width: 225.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppPadding.radius),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1622107795650-24e72a695404?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2946&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeServicesView extends StatelessWidget {
  const HomeServicesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.w,
      runSpacing: 20.w,
      children: List.generate(
          12,
          (index) => Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, Routes.payment),
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius:
                              BorderRadius.circular(AppPadding.radius)),
                    ),
                  ),
                  SizedBox(
                    height: AppPadding.verticalPaddingS,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, Routes.payment),
                    child: Text(
                      'Makanan',
                      style: AppTextStyles.subDescriptionTextStyle
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )),
    );
  }
}

class HomeWelcomeView extends StatelessWidget {
  const HomeWelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
      child: Column(
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
            'Kristanto Wibowo',
            style: AppTextStyles.titleTextStyle,
          ),
        ],
      ),
    );
  }
}

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: AppPadding.horizontalPaddingXL,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.appLogo,
                  width: 20.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'SIMS PPOB',
                  style: AppTextStyles.descriptionTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.borderColor),
                  shape: BoxShape.circle),
              child: Image.asset(
                AppAssets.profilePicture,
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }
}
