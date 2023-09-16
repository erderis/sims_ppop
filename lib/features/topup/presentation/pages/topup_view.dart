import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_dialog_confirm.dart';
import 'package:simsppob/core/widgets/app_dialog_notif.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/core/widgets/saldo_item.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: AppHeader(
            onBack: () {},
            title: 'Top Up',
          )),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
        children: [
          SizedBox(
            height: AppPadding.verticalPaddingL,
          ),
          const SaldoItemView(
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
                controller: TextEditingController(),
                hintText: 'masukkan nominal Top Up',
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
              SizedBox(
                height: AppPadding.verticalPaddingXL,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    List.generate(3, (index) => _buildNominalItem('Rp200.000')),
              ),
              SizedBox(
                height: AppPadding.verticalPaddingL,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    List.generate(3, (index) => _buildNominalItem('Rp20.000')),
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
    );
  }

  Widget _buildNominalItem(String amount) {
    return InkWell(
      onTap: () {},
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
