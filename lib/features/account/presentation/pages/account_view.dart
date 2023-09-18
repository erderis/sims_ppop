import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simsppob/constants/appbar_size.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/features/account/presentation/provider/profile_edit_state_provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/features/account/presentation/widgets/account_data_view.dart';
import 'package:simsppob/features/account/presentation/widgets/account_error_view.dart';
import 'package:simsppob/features/account/presentation/widgets/account_loading_view.dart';
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
          child: Consumer<ProfileProvider>(builder: (_, provider, __) {
            if (provider.dataState.isErrorImage ||
                provider.dataState.isErrorUpdate) {
              Future.delayed(const Duration(milliseconds: 100), () {
                showAppToast(context, message: provider.dataState.error!);
                provider.resetProfileState(
                    currentData: provider.dataState.data);
              });
            }
            if (provider.dataState.isSuccessUpdate) {
              Future.delayed(const Duration(milliseconds: 100), () {
                showAppToast(context,
                    message: 'Profil berhasil diubah!', isSuccess: true);
                provider.resetProfileState(
                    currentData: provider.dataState.data);
              });
            }
            if (provider.dataState.isError) {
              showAppToast(context, message: provider.dataState.error!);
              return AccountErrorView(
                messsage: provider.dataState.error!,
              );
            }

            if (provider.dataState.isLoading) {
              return const AccountLoadingView();
            } else if (provider.dataState.isSuccess) {
              final data = provider.dataState.data!;
              return AccountDataView(
                data: data,
                refreshController: refreshController,
                onRefresh: () => _onRefresh(context,
                    provider: provider, refreshController: refreshController),
              );
            }

            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
