import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';
import 'package:simsppob/utils/helper/format_datetime.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppHeader(
            onBack: () {
              final navbarProvider =
                  Provider.of<NavbarProvider>(context, listen: false);
              navbarProvider.changeNavbar(0);
            },
            title: 'Transaksi',
          )),
      body: Column(
        children: [
          SizedBox(
            height: AppPadding.verticalPaddingL,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.horizontalPaddingXL),
            child: const AppSaldoItemView(),
          ),
          SizedBox(
            height: AppPadding.verticalPaddingL * 2,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.horizontalPaddingXL),
                  child: Text(
                    'Transaksi',
                    style: AppTextStyles.subTitleTextStyle
                        .copyWith(fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                Expanded(child: Consumer<TransactionProvider>(
                    builder: (context, provider, _) {
                  if (provider.dataState.isLoading) {
                    return ListView.builder(
                        itemCount: 4,
                        padding: EdgeInsets.symmetric(
                            vertical: AppPadding.verticalPaddingS,
                            horizontal: AppPadding.horizontalPaddingM),
                        itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: AppPadding.verticalPaddingM * 2),
                              child: const AppShimmer(
                                width: double.infinity,
                                height: 60,
                              ),
                            ));
                  } else if (provider.dataState.isSuccess) {
                    final data = provider.dataState.data!;
                    final isDataEmpty =
                        provider.dataState.data!.records.isEmpty;
                    if (isDataEmpty) {
                      return Center(
                        child: Text(
                          'Belum ada transaksi.',
                          style: AppTextStyles.descriptionTextStyle,
                        ),
                      );
                    }
                    return ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.horizontalPaddingXL),
                      children: [
                        ...List.generate(data.records.length, (index) {
                          final record = data.records[index];
                          final isTopUp = record.transactionType == 'TOPUP';
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.verticalPaddingS,
                                horizontal: AppPadding.horizontalPaddingM),
                            margin: EdgeInsets.only(
                                bottom: AppPadding.verticalPaddingM * 2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.borderColor),
                                borderRadius:
                                    BorderRadius.circular(AppPadding.radius)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${isTopUp ? '+' : '-'}${record.totalAmount}',
                                      style: AppTextStyles.subTitleTextStyle
                                          .copyWith(
                                              color: isTopUp
                                                  ? AppColors.success
                                                  : AppColors.failed),
                                    ),
                                    Text(record.description,
                                        style: AppTextStyles
                                            .subDescriptionTextStyle),
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
                          child: InkWell(
                            onTap: () {
                              provider.getTransactionHistory(
                                  TransactionHistoryParam(
                                      offset: int.parse(data.offset) +
                                          int.parse(data.limit) +
                                          1,
                                      limit: 5));
                            },
                            child: Text(
                              'Show More',
                              style: AppTextStyles.descriptionTextStyle
                                  .copyWith(color: AppColors.accentColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppPadding.verticalPaddingM * 2,
                        )
                      ],
                    );
                  } else if (provider.dataState.isError) {
                    return Center(
                      child: Text(
                        provider.dataState.error!,
                        style: AppTextStyles.descriptionTextStyle,
                      ),
                    );
                  }
                  return const SizedBox();
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
