import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_dialog_confirm.dart';
import 'package:simsppob/core/widgets/app_dialog_notif.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_saldo_item.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/features/topup/presentation/provider/topup_field_state_provider.dart';
import 'package:simsppob/features/topup/presentation/provider/topup_provider.dart';
import 'package:simsppob/features/topup/presentation/widgets/topup_form_view.dart';
import 'package:simsppob/utils/helper/format_currency.dart';
import 'package:simsppob/utils/helper/show_app_dialog_loading.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final provider =
        Provider.of<TopUpFieldStateProvider>(context, listen: false);
    provider.setIsFilled(amountController.text.isNotEmpty);
  }

  void showDialogConfirm<bool>(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AppDialogConfirm(
              title: 'Anda yakin untuk Top Up sebesar',
              amount: 'Rp ${amountController.text}',
              confirmText: 'Ya, lanjutkan Top Up',
            )).then((value) {
      if (value) {
        showAppDialogLoading(context);
        final paymentProvider = sl<TopUpProvider>();
        final amount = int.parse(unformatCurrency(amountController.text));
        paymentProvider.topUp(amount).then((value) {
          Navigator.pop(context);
          if (paymentProvider.dataState.isError) {
            showDialogNotif(context, isSuccess: false);
          } else if (paymentProvider.dataState.isSuccess) {
            showDialogNotif(context, isSuccess: true);
          }
        });
      }
    });
  }

  void showDialogNotif(BuildContext context, {required bool isSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AppDialogNotif(
        isSuccess: isSuccess,
        title: 'Top Up sebesar',
        value: 'Rp10.000',
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

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
            const AppSaldoItemView(),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            TopUpFormView(amountController: amountController),
            SizedBox(
              height: AppPadding.verticalPaddingL * 3,
            ),
            Consumer<TopUpFieldStateProvider>(builder: (context, provider, _) {
              return AppButton(
                  text: 'To Up',
                  buttonColor: provider.isFilled
                      ? AppColors.accentColor
                      : AppColors.buttonDisabledColor,
                  onPressed: provider.isFilled
                      ? () => showDialogConfirm(context)
                      : () {});
            })
          ],
        ),
      ),
    );
  }
}
