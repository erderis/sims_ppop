import 'package:flutter/material.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/utils/helper/email_validator.dart';

class AccountFormView extends StatelessWidget {
  const AccountFormView({
    super.key,
    required this.isEdit,
  });

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          'Email',
          style: AppTextStyles.descriptionTextStyle,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM,
        ),
        AppTextField(
          controller: TextEditingController(),
          hintText: 'masukkan email anda',
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          readOnly: !isEdit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'email tidak boleh kosong';
            } else if (!isValidEmail(value)) {
              return 'alamat email tidak valid';
            }
            return null;
          },
          prefixIcon: Icons.alternate_email,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
        Text(
          'Nama Depan',
          style: AppTextStyles.descriptionTextStyle,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM,
        ),
        AppTextField(
          controller: TextEditingController(),
          hintText: 'nama depan',
          textInputAction: TextInputAction.next,
          readOnly: !isEdit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'nama depan tidak boleh kosong';
            }
            return null;
          },
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
        Text(
          'Nama Belakang',
          style: AppTextStyles.descriptionTextStyle,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM,
        ),
        AppTextField(
          controller: TextEditingController(),
          hintText: 'nama belakang',
          textInputAction: TextInputAction.done,
          readOnly: !isEdit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'nama belakang tidak boleh kosong';
            }
            return null;
          },
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
        AppButton(
            text: isEdit ? 'Simpan' : 'Edit Profil',
            onPressed: () {
              if (isEdit) {
              } else {}
            }),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
        AppButton(
            text: isEdit ? 'Batalkan' : 'Logout',
            isSecondary: true,
            onPressed: () {
              if (isEdit) {
              } else {}
            }),
        SizedBox(
          height: AppPadding.verticalPaddingM * 2,
        ),
      ],
    );
  }
}
