import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_text_field.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/presentation/provider/profile_edit_state_provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/account/presentation/provider/update_profile_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/last_login_provider.dart';
import 'package:simsppob/utils/helper/email_validator.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';

class AccountFormView extends StatefulWidget {
  const AccountFormView({super.key, required this.isEdit, required this.data});

  final bool isEdit;
  final ProfileEntity data;

  @override
  State<AccountFormView> createState() => _AccountFormViewState();
}

class _AccountFormViewState extends State<AccountFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void onEdit(BuildContext context,
      {required UpdateProfileProvider updateProfileProvider}) {
    if (formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      updateProfileProvider
          .updateProfile(ProfileModel(
              email: emailController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text))
          .then((value) {
        context.read<ProfileProvider>().getProfile(isWithLoading: false);
        context.read<ProfileEditStateProvider>().setIsEdit(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.data.email;
    firstNameController.text = widget.data.firstName;
    lastNameController.text = widget.data.lastName;
    return Form(
      key: formKey,
      child: ListView(
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
            controller: emailController,
            hintText: 'masukkan email anda',
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            readOnly: !widget.isEdit,
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
            controller: firstNameController,
            hintText: 'nama depan',
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            readOnly: !widget.isEdit,
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
            controller: lastNameController,
            hintText: 'nama belakang',
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            readOnly: !widget.isEdit,
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
          Consumer<UpdateProfileProvider>(
              builder: (context, updateProfileProvider, _) {
            if (updateProfileProvider.dataState.isError) {
              showAppToast(context,
                  message: updateProfileProvider.dataState.error!);
            }
            return AppButton(
                text: widget.isEdit ? 'Simpan' : 'Edit Profil',
                isLoading: updateProfileProvider.dataState.isLoading,
                onPressed: updateProfileProvider.dataState.isLoading
                    ? () {}
                    : () {
                        if (widget.isEdit) {
                          onEdit(context,
                              updateProfileProvider: updateProfileProvider);
                        } else {
                          context
                              .read<ProfileEditStateProvider>()
                              .setIsEdit(true);
                        }
                      });
          }),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
          AppButton(
              text: widget.isEdit ? 'Batalkan' : 'Logout',
              isSecondary: true,
              onPressed: () {
                if (widget.isEdit) {
                  context.read<ProfileEditStateProvider>().setIsEdit(false);
                } else {
                  context.read<LastLoginProvider>().logout().then((value) =>
                      Navigator.pushReplacementNamed(context, Routes.login));
                }
              }),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
        ],
      ),
    );
  }
}
