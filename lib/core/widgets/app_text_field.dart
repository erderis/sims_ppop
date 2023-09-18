import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<TextInputFormatter>? inputFormatters;
  final IconData prefixIcon;
  final TextInputType? textInputType;
  final Function()? togglePasswordVisibility;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
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
    this.maxLines = 1,
    this.textInputAction,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.readOnly = false,
    required this.prefixIcon,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          prefixIconColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColors.textColor;
            }
            if (states.contains(MaterialState.error)) {
              return AppColors.failed;
            }
            if (controller.text.isNotEmpty) {
              return AppColors.textColor;
            }
            return AppColors.hintTextColor;
          }),
        ),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        style: AppTextStyles.descriptionTextStyle
            .copyWith(fontWeight: FontWeight.w500),
        obscureText: isPassword ? !isPasswordVisible : false,
        maxLines: maxLines,
        textInputAction: textInputAction,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColors.fieldColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: AppPadding.horizontalPaddingS),
          hintStyle: AppTextStyles.descriptionTextStyle.copyWith(
              color: AppColors.hintTextColor, fontWeight: FontWeight.w500),
          errorStyle: AppTextStyles.descriptionTextStyle
              .copyWith(color: AppColors.failed),
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
