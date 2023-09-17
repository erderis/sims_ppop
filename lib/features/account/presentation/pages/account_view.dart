import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/constants/app_assets.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_header.dart';
import 'package:simsppob/features/account/presentation/provider/pick_image_provider.dart';
import 'package:simsppob/features/account/presentation/widgets/account_form_view.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    print('reloaded');
    final pickImageProvider = sl<PickImageProvider>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => pickImageProvider,
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 56),
            child: AppHeader(
              onBack: () {
                final navbarProvider =
                    Provider.of<NavbarProvider>(context, listen: false);
                navbarProvider.changeNavbar(0);
              },
              title: 'Akun',
            )),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.horizontalPaddingXL,
                vertical: AppPadding.verticalPaddingS),
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Consumer<PickImageProvider>(
                          builder: (context, provider, _) {
                        return CircleAvatar(
                          radius: 60.w,
                          backgroundColor: AppColors.backgroundColor,
                          backgroundImage: provider.image != null
                              ? FileImage(File(provider.image!))
                                  as ImageProvider<Object>
                              : const AssetImage(AppAssets.profilePicture),
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => pickImageProvider.pickImageFromGallery(),
                          child: Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.borderColor)),
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
      ),
    );
  }
}
