import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/onboarding/register/data/models/register_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure, void>> register(RegisterModel params);
}
