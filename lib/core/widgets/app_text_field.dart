import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final IconData prefixIcon;
  final TextInputType? textInputType;
  final Function()? togglePasswordVisibility;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final bool readOnly;
  final int? maxLines;

  const AppTextField({
    Key? key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.maxLines,
    this.textInputAction,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.readOnly = false,
    required this.prefixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColors.textColor,
            ),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        style: AppTextStyles.descriptionTextStyle,
        obscureText: isPassword ? !isPasswordVisible : false,
        maxLines: isPassword ? 1 : maxLines,
        textInputAction: textInputAction,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: AppPadding.horizontalPaddingS),
          hintStyle: AppTextStyles.descriptionTextStyle.copyWith(
              color: AppColors.hintTextColor, fontWeight: FontWeight.w500),
          errorStyle: AppTextStyles.descriptionTextStyle
              .copyWith(color: AppColors.failed),
          fillColor: AppColors.fieldColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppPadding.radius),
              borderSide: const BorderSide(color: AppColors.borderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppPadding.radius),
              borderSide: const BorderSide(color: AppColors.borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppPadding.radius),
              borderSide: const BorderSide(color: AppColors.borderColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppPadding.radius),
              borderSide: const BorderSide(color: AppColors.failed)),
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
            // color: controller.text.isNotEmpty
            //     ? AppColors.textColor
            //     : AppColors.hintTextColor,
          ),
          suffixIcon: isPassword
              ? Transform.translate(
                  offset: Offset(-10.w, 0),
                  child: InkWell(
                    onTap: () => togglePasswordVisibility!(),
                    child: SizedBox(
                      width: 30.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            isPasswordVisible
                                ? AppAssets.eye
                                : AppAssets.eyeOff,
                            width: 16.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
