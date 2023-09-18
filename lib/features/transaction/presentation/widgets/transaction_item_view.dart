import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_smart_refresher.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';
import 'package:simsppob/utils/helper/format_currency.dart';
import 'package:simsppob/utils/helper/format_datetime.dart';

class TransactionItemView extends StatelessWidget {
  const TransactionItemView({
    super.key,
    required this.data,
    required this.refreshController,
    required this.onRefresh,
  });

  final TransactionHistoryEntity data;
  final RefreshController refreshController;
  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return AppSmartRefresher(
      controller: refreshController,
      onRefresh: () => onRefresh,
      child: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
        children: [
          ...List.generate(data.records.length, (index) {
            final record = data.records[index];
            final isTopUp = record.transactionType == 'TOPUP';
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppPadding.verticalPaddingS,
                  horizontal: AppPadding.horizontalPaddingM),
              margin: EdgeInsets.only(bottom: AppPadding.verticalPaddingM * 2),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(AppPadding.radius)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${isTopUp ? '+' : '-'} ${formatCurrency(record.totalAmount)}',
                        style: AppTextStyles.subTitleTextStyle.copyWith(
                            color:
                                isTopUp ? AppColors.success : AppColors.failed),
                      ),
                      Text(record.description,
                          style: AppTextStyles.subDescriptionTextStyle),
                    ],
                  ),
                  SizedBox(
                    height: AppPadding.verticalPaddingS,
                  ),
                  Text(
                    formatDateTime(record.createdOn),
                    style: AppTextStyles.subDescriptionTextStyle
                        .copyWith(color: AppColors.hintTextColor),
                  ),
                ],
              ),
            );
          }),
          Align(
            alignment: Alignment.center,
            child:
                Consumer<TransactionProvider>(builder: (context, provider, _) {
              return InkWell(
                onTap: provider.isLoadMoreLoading
                    ? () {}
                    : () {
                        provider.loadMore();
                      },
                child: provider.isLoadMoreLoading
                    ? const SpinKitThreeBounce(
                        size: 15,
                        color: AppColors.accentColor,
                      )
                    : Text(
                        'Show More',
                        style: AppTextStyles.descriptionTextStyle
                            .copyWith(color: AppColors.accentColor),
                      ),
              );
            }),
          ),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          )
        ],
      ),
    );
  }
}
