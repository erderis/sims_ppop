import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/repositories/profile_repo.dart';

class UpdateProfileImageUseCase extends UseCase<ProfileEntity, String> {
  final ProfileRepo repo;

  UpdateProfileImageUseCase(this.repo);
  @override
  Future<Either<Failure, ProfileEntity>> call(String params) {
    return repo.updateProfileImage(params);
  }
}
