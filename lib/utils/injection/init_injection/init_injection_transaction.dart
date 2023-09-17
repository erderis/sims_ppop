import 'package:simsppob/features/transaction/data/datasources/transaction_history_remote.dart';
import 'package:simsppob/features/transaction/data/repositories/transaction_repo_impl.dart';
import 'package:simsppob/features/transaction/domain/repositories/transaction_repo.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';
import 'package:simsppob/features/transaction/presentation/provider/transaction_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionTransaction() async {
  //provider
  sl.registerFactory(() => TransactionProvider(sl()));

  //use cases
  sl.registerLazySingleton(() => GetTransactionHistoryUseCase(sl()));

  //repository
  sl.registerLazySingleton<TransactionRepo>(
      () => TransactionRepoImpl(sl(), sl(), sl()));

  //data source
  sl.registerLazySingleton<TransactionHistoryRemote>(
      () => TransactionHistoryRemoteImpl());
}
