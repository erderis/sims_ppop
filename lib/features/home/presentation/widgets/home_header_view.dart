import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: AppPadding.horizontalPaddingXL,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.appLogo,
                  width: 20.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'SIMS PPOB',
                  style: AppTextStyles.descriptionTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                final navbarProvider =
                    Provider.of<NavbarProvider>(context, listen: false);
                navbarProvider.changeNavbar(3);
              },
              child: Consumer<ProfileProvider>(
                builder: (context, provider, _) {
                  final profileState = provider.dataState;

                  Widget buildProfileImage() {
                    if (profileState.isLoading) {
                      return const SizedBox();
                    } else if (profileState.isSuccess) {
                      final profileImage = profileState.data?.profileImage;

                      if (profileImage != null &&
                          profileImage.isNotEmpty &&
                          !profileImage.contains('null')) {
                        return Image.network(profileImage, fit: BoxFit.cover);
                      }
                    }

                    return Image.asset(AppAssets.profilePicture,
                        fit: BoxFit.cover);
                  }

                  return Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      border: Border.all(color: AppColors.borderColor),
                      shape: BoxShape.circle,
                    ),
                    child: buildProfileImage(),
                  );
                },
              ),
            )
          ],
        ));
  }
}
