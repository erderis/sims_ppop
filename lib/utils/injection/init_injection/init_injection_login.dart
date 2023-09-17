import 'package:simsppob/features/login/data/datasources/login_local.dart';
import 'package:simsppob/features/login/data/datasources/login_remote.dart';
import 'package:simsppob/features/login/data/repositories/login_repo_impl.dart';
import 'package:simsppob/features/login/domain/repositories/login_repo.dart';
import 'package:simsppob/features/login/domain/usecases/login_usacase.dart';
import 'package:simsppob/features/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/features/login/presentation/provider/login_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionLogin() async {
  //provider
  sl.registerFactory(() => LoginProvider(sl()));
  sl.registerFactory(() => LoginPasswordVisibilityProvider());

  //use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  //repository
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<LoginRemote>(() => LoginRemoteImpl());
  sl.registerLazySingleton<LoginLocal>(() => LoginLocalImpl(sl()));
}
