import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/onboarding/login/data/datasources/login_local.dart';
import 'package:simsppob/features/onboarding/login/data/datasources/login_remote.dart';
import 'package:simsppob/features/onboarding/login/data/models/login_model.dart';
import 'package:simsppob/features/onboarding/login/domain/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final NetworkInfo networkInfo;
  final LoginRemote loginRemote;
  final LoginLocal loginLocal;

  LoginRepoImpl(this.networkInfo, this.loginRemote, this.loginLocal);
  @override
  Future<Either<Failure, void>> login(LoginModel params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await loginRemote.login(params);
        return Right(loginLocal.cacheLogin(response.data.token));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorResponse: e.errorResponse));
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLastlogin() async {
    try {
      final response = await loginLocal.getLastLogin();
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteLastlogin() async {
    try {
      final response = await loginLocal.deleteLastLogin();
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
