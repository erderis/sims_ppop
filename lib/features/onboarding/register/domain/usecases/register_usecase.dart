import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/onboarding/register/data/models/register_model.dart';
import 'package:simsppob/features/onboarding/register/domain/repositories/register_repo.dart';

class RegisterUseCase extends UseCase<void, RegisterModel> {
  final RegisterRepo repo;

  RegisterUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(params) {
    return repo.register(params);
  }
}
