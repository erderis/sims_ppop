import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/utils/injection/init_injection/init_login.dart';
import 'package:simsppob/utils/injection/init_injection/init_main.dart';
import 'package:simsppob/utils/injection/init_injection/init_register.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initLogin();
  initRegister();
  initMain();

  //! Core

  // sl.registerLazySingleton<RootInfo>(() => RootInfoImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  final customInstance = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 3), // Custom check interval
    // addresses: _defaultAddresses,
  );
  sl.registerSingleton<InternetConnection>(
    customInstance,
  );
}
