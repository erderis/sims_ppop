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
import 'package:simsppob/features/login/presentation/provider/last_login_provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final RefreshController refreshController = RefreshController();

  void _onRefresh(BuildContext context,
      {required ProfileProvider provider}) async {
    provider.getProfile(isWithLoading: false);
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ProfileEditStateProvider>(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: appBarSize,
            child: AppHeader(
              onBack: () {
                final navbarProvider =
                    Provider.of<NavbarProvider>(context, listen: false);
                navbarProvider.changeNavbar(0);
              },
              title: 'Akun',
            )),
        body: SafeArea(
          child: Consumer<ProfileProvider>(builder: (context, provider, _) {
            if (provider.dataState.isLoading) {
              return const AccountLoadingView();
            } else if (provider.dataState.isSuccess) {
              final data = provider.dataState.data!;
              emailController.text = data.email;
              firstNameController.text = data.firstName;
              lastNameController.text = data.lastName;
              return AppSmartRefresher(
                controller: refreshController,
                onRefresh: () => _onRefresh(context, provider: provider),
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
                        emailController: emailController,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        formKey: formKey,
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
