import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/onboarding/login/data/datasources/login_local.dart';
import 'package:simsppob/features/topup/data/datasources/topup_remote.dart';
import 'package:simsppob/features/topup/domain/repositories/topup_repo.dart';

class TopUpRepoImpl implements TopUpRepo {
  final NetworkInfo networkInfo;
  final LoginLocal loginLocal;
  final TopUpRemote topUpRemote;

  TopUpRepoImpl(
    this.networkInfo,
    this.loginLocal,
    this.topUpRemote,
  );

  @override
  Future<Either<Failure, BalanceEntity>> topup(int params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await topUpRemote.topUp(amount: params, token: token);
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
