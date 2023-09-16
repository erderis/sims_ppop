import 'package:simsppob/features/register/data/datasources/register_remote.dart';
import 'package:simsppob/features/register/data/repositories/register_repo_impl.dart';
import 'package:simsppob/features/register/domain/repositories/register_repo.dart';
import 'package:simsppob/features/register/domain/usecases/register_usecase.dart';
import 'package:simsppob/features/register/presentation/cubit/register_password_confirm_visibility_cubit.dart';
import 'package:simsppob/features/register/presentation/cubit/register_password_visibility_cubit.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initRegister() async {
  //bloc
  // sl.registerFactory(() => RegisterBloc());
  sl.registerFactory(() => RegisterPasswordVisibilityCubit());
  sl.registerFactory(() => RegisterPasswordConfirmVisibilityCubit());

  //use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  //repository
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepoImpl(sl(), sl()));

  //data source
  sl.registerLazySingleton<RegisterRemote>(() => RegisterRemoteImpl());
}
