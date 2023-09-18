import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/home/presentation/provider/banner_provider.dart';
import 'package:simsppob/features/home/presentation/provider/services_provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';

void reloadAllState(BuildContext context) {
  Provider.of<NavbarProvider>(context, listen: false).changeNavbar(0);
  Provider.of<BalanceProvider>(context, listen: false).getBalance();
  Provider.of<ServicesProvider>(context, listen: false).getServices();
  Provider.of<BannerProvider>(context, listen: false).getBanner();
  Provider.of<TransactionProvider>(context, listen: false)
      .getTransactionHistory();
  Provider.of<ProfileProvider>(context, listen: false).getProfile();
}
