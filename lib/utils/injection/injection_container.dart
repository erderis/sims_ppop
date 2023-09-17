import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_home.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_login.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_main.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_payment.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_profile.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_register.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_topup.dart';
import 'package:simsppob/utils/injection/init_injection/init_injection_transaction.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! features
  initInjectionLogin();
  initInjectionRegister();
  initInjectionMain();
  initInjectionProfile();
  initInjectionHome();
  initInjectionTopUp();
  initInjectionPayment();
  initInjectionTransaction();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  final customInstance = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 3),
    // addresses: _defaultAddresses,
  );
  sl.registerSingleton<InternetConnection>(
    customInstance,
  );
}
