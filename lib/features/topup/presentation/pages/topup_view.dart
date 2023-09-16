import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_dialog_confirm.dart';
import 'package:simsppob/core/widgets/app_dialog_notif.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/helper/format_currency.dart';

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  final _amountController = TextEditingController();
  final amountTemplates = [
    '10.000',
    '20.000',
    '50.000',
    '10.0000',
    '250.000',
    '500.000'
  ];
  void showDialogConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialogConfirm(
          title: 'Apakah anda yakin untuk Top Up sebesar',
          amount: 'Rp 10.000',
          confirmText: 'Ya, lanjutkan Top Up',
          onConfirm: () {}),
    );
  }

  void showDialogNotif(BuildContext context, {required bool isSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AppDialogNotif(
        isSuccess: isSuccess,
        title: 'Top Up sebesar',
        amount: 'Rp10.000',
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: AppHeader(
            onBack: () {
              final navbarProvider =
                  Provider.of<NavbarProvider>(context, listen: false);
              navbarProvider.changeNavbar(0);
            },
            title: 'Top Up',
          )),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
          children: [
            SizedBox(
              height: AppPadding.verticalPaddingL,
            ),
            const AppSaldoItemView(
              amount: 'Rp 0',
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Silahkan Masukkan',
                  style: AppTextStyles.subTitleTextStyle
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingS / 2,
                ),
                Text(
                  'Nominal Top Up',
                  style: AppTextStyles.subTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                AppTextField(
                  controller: _amountController,
                  hintText: 'masukkan nominal Top Up',
                  textInputType: TextInputType.number,
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
                SizedBox(
                  height: AppPadding.verticalPaddingXL,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(amountTemplates.length - 3,
                      (index) => _buildNominalItem(amountTemplates[index])),
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingL,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(amountTemplates.length - 3,
                      (index) => _buildNominalItem(amountTemplates[index + 3])),
                ),
              ],
            ),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            AppButton(
                text: 'To Up',
                onPressed: () => showDialogConfirm(
                      context,
                    ))
          ],
        ),
      ),
    );
  }

  Widget _buildNominalItem(String amount) {
    return InkWell(
      onTap: () {
        _amountController.value = _amountController.value.copyWith(
          text: amount,
          selection: TextSelection.collapsed(offset: amount.length),
        );
      },
      child: Container(
        width: 100.w,
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(AppPadding.radius),
        ),
        child: Center(
          child: Text(
            amount,
            style: AppTextStyles.descriptionTextStyle,
          ),
        ),
      ),
    );
  }
}
