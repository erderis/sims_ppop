import 'package:simsppob/features/register/data/datasources/register_remote.dart';
import 'package:simsppob/features/register/data/repositories/register_repo_impl.dart';
import 'package:simsppob/features/register/domain/repositories/register_repo.dart';
import 'package:simsppob/features/register/domain/usecases/register_usecase.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_confirm_visibility_provider.dart';
import 'package:simsppob/features/register/presentation/provider/register_password_visibility_provider.dart';
import 'package:simsppob/features/register/presentation/provider/register_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionRegister() async {
  //provider
  sl.registerFactory(() => RegisterProvider(sl()));
  sl.registerFactory(() => RegisterPasswordVisibilityProvider());
  sl.registerFactory(() => RegisterPasswordConfirmVisibilityProvider());

  //use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  //repository
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepoImpl(sl(), sl()));

  //data source
  sl.registerLazySingleton<RegisterRemote>(() => RegisterRemoteImpl());
}
