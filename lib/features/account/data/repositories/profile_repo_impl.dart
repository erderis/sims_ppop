import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/account/data/datasources/profile_remote.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/repositories/profile_repo.dart';
import 'package:simsppob/features/login/data/datasources/login_local.dart';

class ProfileRepoImpl implements ProfileRepo {
  final NetworkInfo networkInfo;
  final ProfileRemote profileRemote;
  final LoginLocal loginLocal;

  ProfileRepoImpl(this.networkInfo, this.profileRemote, this.loginLocal);
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await profileRemote.getProfile(token);
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
  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileModel params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await profileRemote.updateProfile(
            profileModel: params, token: token);
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
  Future<Either<Failure, ProfileEntity>> updateProfileImage(
      String params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await loginLocal.getLastLogin();
        final response = await profileRemote.updateProfileImage(
            filePath: params, token: token);
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
