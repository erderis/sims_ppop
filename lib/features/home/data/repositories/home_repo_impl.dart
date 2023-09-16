import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/home/data/datasources/balance_remote.dart';
import 'package:simsppob/features/home/data/datasources/banner_remote.dart';
import 'package:simsppob/features/home/data/datasources/services_remote.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/home/domain/entities/banner_entity.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/home/domain/repositories/home_repo.dart';
import 'package:simsppob/features/login/data/datasources/login_local.dart';

class HomeRepoImpl implements HomeRepo {
  final NetworkInfo networkInfo;
  final LoginLocal loginLocal;
  final BannerRemote bannerRemote;
  final ServicesRemote servicesRemote;
  final BalanceRemote balanceRemote;

  HomeRepoImpl(this.networkInfo, this.loginLocal, this.bannerRemote,
      this.servicesRemote, this.balanceRemote);
  @override
  Future<Either<Failure, List<BannerEntity>>> getBanner() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await bannerRemote.getBanner(token);
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

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await servicesRemote.getServices(token);
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

  @override
  Future<Either<Failure, BalanceEntity>> getBalance() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await balanceRemote.getBalance(token);
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
