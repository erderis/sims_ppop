import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/login/data/models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, void>> login(LoginModel params);
  Future<Either<Failure, String>> getLastlogin();
  Future<Either<Failure, void>> deleteLastlogin();
}
