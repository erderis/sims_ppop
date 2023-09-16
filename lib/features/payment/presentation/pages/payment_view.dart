import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_dialog_confirm.dart';
import 'package:simsppob/core/widgets/app_dialog_notif.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/core/widgets/saldo_item.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  void showDialogConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialogConfirm(
          title: 'Beli listrik prabayar senilai',
          amount: 'Rp10.000',
          confirmText: 'Ya, lanjutkan bayar',
          onConfirm: () {}),
    );
  }

  void showDialogNotif(BuildContext context, {required bool isSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AppDialogNotif(
        isSuccess: isSuccess,
        title: 'Pembayaran listrik prabayar sebesar',
        amount: 'Rp10.000',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: AppHeader(
            onBack: () => Navigator.pop(context),
            title: 'Pembayaran',
          )),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
        children: [
          SizedBox(height: AppPadding.verticalPaddingL),
          SaldoItemView(
            amount: 'Rp 10.000',
          ),
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
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(AppPadding.radius)),
                  ),
                  SizedBox(
                    width: AppPadding.horizontalPaddingS / 2,
                  ),
                  Text(
                    'Listrik Prabayar',
                    style: AppTextStyles.descriptionTextStyle
                        .copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: AppPadding.verticalPaddingM * 2,
              ),
              AppTextField(
                controller: TextEditingController(),
                hintText: 'masukkan nominal pembayaran',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
              text: 'Bayar',
              onPressed: () => showDialogConfirm(
                    context,
                  ))
        ],
      ),
    );
  }
}
