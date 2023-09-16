import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/features/account/presentation/widgets/account_form_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: AppHeader(
            onBack: () {},
            title: 'Akun',
          )),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.horizontalPaddingXL,
              vertical: AppPadding.verticalPaddingM * 2),
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 118.w,
                      height: 118.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderColor)),
                      child: Image.asset(
                        AppAssets.profilePicture,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.borderColor)),
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppPadding.verticalPaddingM * 2,
                ),
                Text(
                  'Kristanto Wibowo',
                  style: AppTextStyles.titleTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: AppPadding.verticalPaddingM * 2,
            ),
            const AccountFormView(
              isEdit: true,
            ),
          ],
        ),
      ),
    );
  }
}
