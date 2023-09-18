import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_dialog_confirm.dart';
import 'package:simsppob/core/widgets/app_dialog_notif.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/payment/presentation/provider/payment_provider.dart';
import 'package:simsppob/utils/helper/format_currency.dart';
import 'package:simsppob/utils/helper/show_app_dialog_loading.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';
import 'package:simsppob/utils/helper/update_balance_transaction.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.service});

  final ServiceEntity service;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final paymentController = TextEditingController();

  @override
  void initState() {
    paymentController.text =
        formatCurrency(widget.service.serviceTariff, symbol: '');
    super.initState();
  }

  void showDialogConfirm<bool>(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialogConfirm(
        title: 'Beli ${widget.service.serviceName} prabayar senilai',
        amount: formatCurrency(widget.service.serviceTariff),
        confirmText: 'Ya, lanjutkan bayar',
      ),
    ).then((value) {
      if (value != null) {
        if (value) {
          showAppDialogLoading(context);
          final paymentProvider = sl<PaymentProvider>();
          paymentProvider.transaction(widget.service.serviceCode).then((value) {
            Navigator.pop(context);
            if (paymentProvider.dataState.isError) {
              showDialogNotif(context, isSuccess: false);
              showAppToast(context, message: paymentProvider.dataState.error!);
            } else if (paymentProvider.dataState.isSuccess) {
              showDialogNotif(context, isSuccess: true);
              updateBalanceTransaction(context);
            }
          });
        }
      }
    });
  }

  void showDialogNotif(BuildContext context, {required bool isSuccess}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppDialogNotif(
        isSuccess: isSuccess,
        title: 'Pembayaran ${widget.service.serviceName} prabayar sebesar',
        value: formatCurrency(widget.service.serviceTariff),
      ),
    );
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppHeader(
            onBack: () => Navigator.pop(context),
            title: 'Pembayaran',
          )),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
          children: [
            SizedBox(height: AppPadding.verticalPaddingL),
            const AppSaldoItemView(),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pembayaran',
                  style: AppTextStyles.descriptionTextStyle,
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingM,
                ),
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          image: DecorationImage(
                              image: NetworkImage(widget.service.serviceIcon)),
                          borderRadius:
                              BorderRadius.circular(AppPadding.radius)),
                    ),
                    SizedBox(
                      width: AppPadding.horizontalPaddingS / 2,
                    ),
                    Text(
                      widget.service.serviceName,
                      style: AppTextStyles.descriptionTextStyle
                          .copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                AppTextField(
                  controller: paymentController,
                  hintText: '',
                  textInputType: TextInputType.number,
                  readOnly: true,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'id', symbol: '', decimalDigits: 0)
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'nominal tidak boleh kosong';
                    }
                    return null;
                  },
                  prefixIcon: Icons.money,
                ),
              ],
            ),
            SizedBox(
              height: 212.h,
            ),
            AppButton(
                text: 'Bayar', onPressed: () => showDialogConfirm(context))
          ],
        ),
      ),
    );
  }
}
