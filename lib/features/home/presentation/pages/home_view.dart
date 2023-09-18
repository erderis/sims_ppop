import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/core/widgets/app_smart_refresher.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/home/presentation/provider/banner_provider.dart';
import 'package:simsppob/features/home/presentation/provider/services_provider.dart';
import 'package:simsppob/features/home/presentation/widgets/home_banner_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_header_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_service_view.dart';
import 'package:simsppob/features/home/presentation/widgets/home_welcome_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onRefresh(BuildContext context,
      {required RefreshController refreshController}) async {
    Provider.of<BalanceProvider>(context, listen: false)
        .getBalance(isWithLoading: false);
    Provider.of<ServicesProvider>(context, listen: false)
        .getServices(isWithLoading: false);
    Provider.of<BannerProvider>(context, listen: false)
        .getBanner(isWithLoading: false);
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: appBarSize,
        child: HomeHeaderView(),
      ),
      body: AppSmartRefresher(
        controller: refreshController,
        onRefresh: () =>
            _onRefresh(context, refreshController: refreshController),
        child: ListView(
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
      ),
    );
  }
}
