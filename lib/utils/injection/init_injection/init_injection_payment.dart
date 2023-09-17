import 'package:simsppob/features/payment/data/datasources/payment_remote.dart';
import 'package:simsppob/features/payment/data/repositories/payment_repo_impl.dart';
import 'package:simsppob/features/payment/domain/repositories/payment_repo.dart';
import 'package:simsppob/features/payment/domain/usecases/transaction_usecase.dart';
import 'package:simsppob/features/payment/presentation/provider/payment_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionPayment() async {
  //provider
  sl.registerFactory(() => PaymentProvider(sl()));

  //use cases
  sl.registerLazySingleton(() => TransactionUseCase(sl()));

  //repository
  sl.registerLazySingleton<PaymentRepo>(
      () => PaymentRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<PaymentRemote>(() => PaymentRemoteImpl());
}
