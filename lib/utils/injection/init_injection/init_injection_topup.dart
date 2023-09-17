import 'package:simsppob/features/topup/data/datasources/topup_remote.dart';
import 'package:simsppob/features/topup/data/repositories/topup_repo_impl.dart';
import 'package:simsppob/features/topup/domain/repositories/topup_repo.dart';
import 'package:simsppob/features/topup/domain/usecases/topup_usecase.dart';
import 'package:simsppob/features/topup/presentation/provider/topup_field_state_provider.dart';
import 'package:simsppob/features/topup/presentation/provider/topup_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionTopUp() async {
  //provider
  sl.registerFactory(() => TopUpProvider(sl()));
  sl.registerFactory(() => TopUpFieldStateProvider());

  //use cases
  sl.registerLazySingleton(() => TopUpUseCase(sl()));

  //repository
  sl.registerLazySingleton<TopUpRepo>(() => TopUpRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<TopUpRemote>(() => TopUpRemoteImpl());
}
