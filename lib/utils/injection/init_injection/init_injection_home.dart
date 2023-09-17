import 'package:simsppob/features/home/data/datasources/balance_remote.dart';
import 'package:simsppob/features/home/data/datasources/banner_remote.dart';
import 'package:simsppob/features/home/data/datasources/services_remote.dart';
import 'package:simsppob/features/home/data/repositories/home_repo_impl.dart';
import 'package:simsppob/features/home/domain/repositories/home_repo.dart';
import 'package:simsppob/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:simsppob/features/home/domain/usecases/get_banner_usecase.dart';
import 'package:simsppob/features/home/domain/usecases/get_services_usecase.dart';
import 'package:simsppob/features/home/presentation/provider/balance_provider.dart';
import 'package:simsppob/features/home/presentation/provider/banner_provider.dart';
import 'package:simsppob/features/home/presentation/provider/saldo_visibility_provider.dart';
import 'package:simsppob/features/home/presentation/provider/services_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionHome() async {
  //provider
  sl.registerFactory(() => BalanceProvider(sl()));
  sl.registerFactory(() => ServicesProvider(sl()));
  sl.registerFactory(() => BannerProvider(sl()));
  sl.registerFactory(() => SaldoVisibilityProvider());

  //use cases
  sl.registerLazySingleton(() => GetBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(sl()));
  sl.registerLazySingleton(() => GetBannerUseCase(sl()));

  //repository
  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(sl(), sl(), sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<BalanceRemote>(() => BalanceRemoteImpl());
  sl.registerLazySingleton<ServicesRemote>(() => ServicesRemoteImpl());
  sl.registerLazySingleton<BannerRemote>(() => BannerRemoteImpl());
}
