import 'package:simsppob/features/login/presentation/pages/login_view.dart';
import 'package:simsppob/features/main/presentation/pages/main_view.dart';
import 'package:simsppob/features/payment/presentation/pages/payment_view.dart';
import 'package:simsppob/features/register/presentation/pages/register_view.dart';
import 'package:simsppob/features/splash/presentation/pages/splash_view.dart';

import './app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(args);
    Map<String, dynamic> newArgs = {};
    if (args != null) {
      newArgs = args as Map<String, dynamic>;
    }
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.payment:
        return MaterialPageRoute(
            builder: (_) => PaymentView(
                  service: newArgs['service'],
                ));

      default:
        return null;
    }
  }
}
