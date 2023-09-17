import 'package:simsppob/features/account/data/datasources/profile_remote.dart';
import 'package:simsppob/features/account/data/repositories/profile_repo_impl.dart';
import 'package:simsppob/features/account/domain/repositories/profile_repo.dart';
import 'package:simsppob/features/account/domain/usecases/get_profile_usecase.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_image_usecase.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_usecase.dart';
import 'package:simsppob/features/account/presentation/provider/pick_image_provider.dart';
import 'package:simsppob/features/account/presentation/provider/profile_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionProfile() async {
  //provider
  sl.registerFactory(() => ProfileProvider(sl(), sl(), sl()));
  sl.registerFactory(() => PickImageProvider());

  //use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileImageUseCase(sl()));

  //repository
  sl.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<ProfileRemote>(() => ProfileRemoteImpl());
}
