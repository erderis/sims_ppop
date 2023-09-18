import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_smart_refresher.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/presentation/provider/profile_edit_state_provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/account/presentation/widgets/account_form_view.dart';

class AccountDataView extends StatelessWidget {
  const AccountDataView(
      {super.key,
      required this.data,
      required this.refreshController,
      required this.onRefresh});

  final RefreshController refreshController;
  final Function() onRefresh;
  final ProfileEntity data;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProfileProvider>();
    return AppSmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontalPaddingXL,
            vertical: AppPadding.verticalPaddingS),
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Consumer<ProfileProvider>(
                      builder: (context, profileProvider, _) {
                    if (profileProvider.dataState.isLoadingImage) {
                      return CircleAvatar(
                        radius: 60.w,
                        backgroundColor: AppColors.borderColor,
                        child: const CircularProgressIndicator(
                          color: AppColors.accentColor,
                        ),
                      );
                    }

                    return CircleAvatar(
                      radius: 60.w,
                      backgroundColor: AppColors.borderColor,
                      backgroundImage: !data.profileImage.contains('null')
                          ? NetworkImage(data.profileImage)
                              as ImageProvider<Object>
                          : const AssetImage(AppAssets.profilePicture),
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => provider.pickImage(
                        context,
                        currentData: provider.dataState.data,
                      ),
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
                height: AppPadding.verticalPaddingM,
              ),
              Text(
                '${data.firstName} ${data.lastName}',
                style: AppTextStyles.titleTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: AppPadding.verticalPaddingM * 2,
          ),
          Consumer<ProfileEditStateProvider>(
              builder: (context, providerEdit, _) {
            return AccountFormView(
              isEdit: providerEdit.isEdit,
              data: data,
            );
          }),
        ],
      ),
    );
  }
}
