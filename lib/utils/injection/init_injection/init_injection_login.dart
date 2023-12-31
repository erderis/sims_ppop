import 'package:simsppob/features/onboarding/login/data/datasources/login_local.dart';
import 'package:simsppob/features/onboarding/login/data/datasources/login_remote.dart';
import 'package:simsppob/features/onboarding/login/data/repositories/login_repo_impl.dart';
import 'package:simsppob/features/onboarding/login/domain/repositories/login_repo.dart';
import 'package:simsppob/features/onboarding/login/domain/usecases/delete_last_login_usecase.dart';
import 'package:simsppob/features/onboarding/login/domain/usecases/get_last_login_usacase.dart';
import 'package:simsppob/features/onboarding/login/domain/usecases/login_usacase.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/last_login_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/features/onboarding/login/presentation/provider/login_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionLogin() async {
  //provider
  sl.registerFactory(() => LoginProvider(sl()));
  sl.registerFactory(() => LastLoginProvider(sl(), sl()));
  sl.registerFactory(() => LoginPasswordVisibilityProvider());

  //use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetLastLoginUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLastLoginUseCase(sl()));

  //repository
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<LoginRemote>(() => LoginRemoteImpl());
  sl.registerLazySingleton<LoginLocal>(() => LoginLocalImpl(sl()));
}
