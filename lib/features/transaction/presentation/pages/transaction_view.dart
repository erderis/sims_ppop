import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/saldo_item.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: AppHeader(
            onBack: () {},
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
            child: const SaldoItemView(
              amount: 'Rp 10.000',
            ),
          ),
          SizedBox(
            height: AppPadding.verticalPaddingL * 3,
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
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.horizontalPaddingXL),
                  children: [
                    ...List.generate(
                        3,
                        (index) => Container(
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
                                        '+ Rp 50.000',
                                        style: AppTextStyles.subTitleTextStyle
                                            .copyWith(color: AppColors.success),
                                      ),
                                      Text('Top Up Saldo',
                                          style: AppTextStyles
                                              .subDescriptionTextStyle),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppPadding.verticalPaddingS,
                                  ),
                                  Text(
                                    '17 Agustus 2023  12:10 WIB',
                                    style: AppTextStyles.subDescriptionTextStyle
                                        .copyWith(
                                            color: AppColors.hintTextColor),
                                  ),
                                ],
                              ),
                            )),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Show More',
                        style: AppTextStyles.descriptionTextStyle
                            .copyWith(color: AppColors.accentColor),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
