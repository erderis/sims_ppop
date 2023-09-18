import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/onboarding/login/domain/repositories/login_repo.dart';

class DeleteLastLoginUseCase extends UseCase<void, NoParams> {
  final LoginRepo repo;

  DeleteLastLoginUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(params) {
    return repo.deleteLastlogin();
  }
}
