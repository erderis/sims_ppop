import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/login/domain/repositories/login_repo.dart';

class GetLastLoginUseCase extends UseCase<void, NoParams> {
  final LoginRepo repo;

  GetLastLoginUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(params) {
    return repo.getLastlogin();
  }
}
