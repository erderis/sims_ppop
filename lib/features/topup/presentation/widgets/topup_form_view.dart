import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';

class TopUpFormView extends StatelessWidget {
  const TopUpFormView({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final amountTemplates = [
      '10.000',
      '20.000',
      '50.000',
      '10.0000',
      '250.000',
      '500.000'
    ];

    return Column(
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
          controller: amountController,
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
    );
  }

  Widget _buildNominalItem(String amount) {
    return InkWell(
      onTap: () {
        amountController.value = amountController.value.copyWith(
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
