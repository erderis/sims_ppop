import 'package:flutter/material.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/payment/presentation/widgets/payment_body_view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.service});

  final ServiceEntity service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppHeader(
            onBack: () => Navigator.pop(context),
            title: 'Pembayaran',
          )),
      body: PaymentBodyView(service: service),
    );
  }
}
