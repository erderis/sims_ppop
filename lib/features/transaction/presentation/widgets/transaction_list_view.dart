import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_smart_refresher.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';
import 'package:simsppob/features/transaction/presentation/widgets/transaction_item_view.dart';
import 'package:simsppob/features/transaction/presentation/widgets/transaction_loading_view.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key});

  void _onRefresh(BuildContext context,
      {required RefreshController refreshController,
      required TransactionProvider provider}) async {
    provider.getTransactionHistory(isWithLoading: false);
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
          child: Text(
            'Transaksi',
            style: AppTextStyles.subTitleTextStyle.copyWith(fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
        Expanded(child:
            Consumer<TransactionProvider>(builder: (context, provider, _) {
          if (provider.dataState.isLoading) {
            return const TransactionLoadingView();
          } else if (provider.dataState.isError) {
            return _buildEmptyErrorView(context,
                refreshController: refreshController,
                provider: provider,
                message: provider.dataState.error!);
          } else if (provider.dataState.isSuccess) {
            final data = provider.dataState.data!;
            final isDataEmpty = provider.dataState.data!.records.isEmpty;
            if (isDataEmpty) {
              return _buildEmptyErrorView(context,
                  refreshController: refreshController,
                  provider: provider,
                  message: 'Belum ada transaksi.');
            }
            return TransactionItemView(
                data: data,
                refreshController: refreshController,
                onRefresh: () => _onRefresh(context,
                    refreshController: refreshController, provider: provider));
          }
          return const SizedBox();
        }))
      ],
    );
  }

  Widget _buildEmptyErrorView(BuildContext context,
      {required RefreshController refreshController,
      required TransactionProvider provider,
      required String message}) {
    return AppSmartRefresher(
      controller: refreshController,
      onRefresh: () => _onRefresh(context,
          refreshController: refreshController, provider: provider),
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.descriptionTextStyle,
        ),
      ),
    );
  }
}
