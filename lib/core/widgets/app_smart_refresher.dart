import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_colors.dart';

class AppSmartRefresher extends StatelessWidget {
  const AppSmartRefresher(
      {super.key,
      required this.controller,
      required this.onRefresh,
      required this.child});

  final RefreshController controller;
  final VoidCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: const WaterDropHeader(
        waterDropColor: AppColors.accentColor,
      ),
      controller: controller,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
