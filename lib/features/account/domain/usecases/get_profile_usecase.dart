import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/repositories/profile_repo.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepo repo;

  GetProfileUseCase(this.repo);
  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return repo.getProfile();
  }
}
