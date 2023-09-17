import 'package:flutter/material.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/features/home/presentation/widgets/home_banner_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_header_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_service_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_welcome_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: appBarSize,
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
                isHome: true,
              )),
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
