import 'package:flutter/material.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';

class TransactionLoadingView extends StatelessWidget {
  const TransactionLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.verticalPaddingS,
            horizontal: AppPadding.horizontalPaddingM),
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.verticalPaddingM * 2),
              child: const AppShimmer(
                height: 60,
              ),
            ));
  }
}
