import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/login/data/models/login_model.dart';
import 'package:simsppob/features/login/domain/repositories/login_repo.dart';

class LoginUseCase extends UseCase<void, LoginModel> {
  final LoginRepo repo;

  LoginUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(LoginModel params) {
    return repo.login(params);
  }
}
