import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_text_style.dart';

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
      header: WaterDropHeader(
        waterDropColor: AppColors.accentColor,
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.done, color: AppColors.hintTextColor),
            Container(
              width: 15.0,
            ),
            Text(
              'Refresh Selesai',
              style: AppTextStyles.descriptionTextStyle
                  .copyWith(color: AppColors.hintTextColor),
            )
          ],
        ),
      ),
      controller: controller,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
