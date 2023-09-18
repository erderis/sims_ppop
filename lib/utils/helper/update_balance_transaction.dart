import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';

void updateBalanceTransaction(BuildContext context) {
  final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
  final transactionProvider =
      Provider.of<TransactionProvider>(context, listen: false);
  balanceProvider.getBalance(isWithLoading: false);
  transactionProvider.getTransactionHistory(isWithLoading: false);
}
