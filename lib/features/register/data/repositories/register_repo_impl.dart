import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/network/network_info.dart';
import 'package:simsppob/features/register/data/datasources/register_remote.dart';
import 'package:simsppob/features/register/data/models/register_model.dart';
import 'package:simsppob/features/register/domain/repositories/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final NetworkInfo networkInfo;
  final RegisterRemote remote;

  RegisterRepoImpl(this.networkInfo, this.remote);
  @override
  Future<Either<Failure, void>> register(RegisterModel params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remote.register(params);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorResponse: e.errorResponse));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
