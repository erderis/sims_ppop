import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_pages.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/features/home/presentation/provider/saldo_visibility_provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart' as di;

import 'utils/injection/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(Platform.isAndroid
      ? const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent)
      : SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const SIMSPPOB());
  });
}

class SIMSPPOB extends StatelessWidget {
  const SIMSPPOB({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<NavbarProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaldoVisibilityProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIMS PPOB',
        theme: ThemeData(
            fontFamily: 'Inter',
            primaryColor: AppColors.accentColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: AppColors.backgroundColor),
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
