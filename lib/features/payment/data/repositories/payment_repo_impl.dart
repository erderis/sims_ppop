import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/login/data/datasources/login_local.dart';
import 'package:simsppob/features/payment/data/datasources/payment_remote.dart';
import 'package:simsppob/features/payment/domain/entities/transaction_entity.dart';
import 'package:simsppob/features/payment/domain/repositories/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final NetworkInfo networkInfo;
  final LoginLocal loginLocal;
  final PaymentRemote paymentRemote;

  PaymentRepoImpl(
    this.networkInfo,
    this.loginLocal,
    this.paymentRemote,
  );

  @override
  Future<Either<Failure, TransactionEntity>> transaction(String params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response =
            await paymentRemote.transaction(serviceCode: params, token: token);
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
