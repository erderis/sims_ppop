import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/onboarding/login/data/datasources/login_local.dart';
import 'package:simsppob/features/transaction/data/datasources/transaction_history_remote.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/domain/repositories/transaction_repo.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';

class TransactionRepoImpl implements TransactionRepo {
  final NetworkInfo networkInfo;
  final LoginLocal loginLocal;
  final TransactionHistoryRemote historyRemote;

  TransactionRepoImpl(
    this.networkInfo,
    this.loginLocal,
    this.historyRemote,
  );

  @override
  Future<Either<Failure, TransactionHistoryEntity>> getTransactionHistory(
      TransactionHistoryParam params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await historyRemote.getTransactionHistory(
            params: params, token: token);
        return Right(response.data);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorResponse: e.errorResponse));
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
