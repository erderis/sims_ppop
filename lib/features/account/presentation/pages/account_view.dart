import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_button.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/core/widgets/app_smart_refresher.dart';
import 'package:simsppob/features/account/presentation/provider/profile_edit_state_provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/account/presentation/provider/update_profile_image_provider.dart';
import 'package:simsppob/features/account/presentation/widgets/account_form_view.dart';
import 'package:simsppob/features/account/presentation/widgets/account_loading_view.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/last_login_provider.dart';
import 'package:simsppob/utils/helper/on_back_navbar.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  void _onRefresh(BuildContext context,
      {required RefreshController refreshController,
      required ProfileProvider provider}) async {
    provider.getProfile(isWithLoading: false);
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController();

    return ChangeNotifierProvider(
      create: (_) => sl<ProfileEditStateProvider>(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: appBarSize,
            child: AppHeader(
              onBack: () => onBackNavbar(context),
              title: 'Akun',
            )),
        body: SafeArea(
          child: Consumer<ProfileProvider>(builder: (context, provider, _) {
            if (provider.dataState.isLoading) {
              return const AccountLoadingView();
            } else if (provider.dataState.isSuccess) {
              final data = provider.dataState.data!;

              return AppSmartRefresher(
                controller: refreshController,
                onRefresh: () => _onRefresh(context,
                    provider: provider, refreshController: refreshController),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.horizontalPaddingXL,
                      vertical: AppPadding.verticalPaddingS),
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Consumer<UpdateProfileImageProvider>(
                                builder: (context, updatemageProvider, _) {
                              if (provider.dataState.isLoading) {
                                return CircleAvatar(
                                  radius: 60.w,
                                  backgroundColor: AppColors.borderColor,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.accentColor,
                                  ),
                                );
                              }
                              if (provider.dataState.isError) {
                                showAppToast(context,
                                    message: provider.dataState.error!);
                              }
                              return CircleAvatar(
                                radius: 60.w,
                                backgroundColor: AppColors.backgroundColor,
                                foregroundColor: AppColors.borderColor,
                                backgroundImage:
                                    !data.profileImage.contains('null')
                                        ? NetworkImage(data.profileImage)
                                            as ImageProvider<Object>
                                        : const AssetImage(
                                            AppAssets.profilePicture),
                              );
                            }),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () => context
                                    .read<UpdateProfileImageProvider>()
                                    .pickImage(context),
                                child: Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.borderColor)),
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
            } else if (provider.dataState.isError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.horizontalPaddingXL),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.dataState.error!,
                        style: AppTextStyles.descriptionTextStyle,
                      ),
                      SizedBox(
                        height: AppPadding.verticalPaddingL,
                      ),
                      AppButton(
                          text: 'Logout',
                          onPressed: () {
                            context.read<LastLoginProvider>().logout().then(
                                (value) => Navigator.pushReplacementNamed(
                                    context, Routes.login));
                          }),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
