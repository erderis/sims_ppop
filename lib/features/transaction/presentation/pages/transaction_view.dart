import 'package:flutter/material.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/features/transaction/presentation/widgets/transaction_list_view.dart';
import 'package:simsppob/utils/helper/on_back_navbar.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppHeader(
            onBack: () => onBackNavbar(context),
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
          const Expanded(child: TransactionListView()),
        ],
      ),
    );
  }
}
