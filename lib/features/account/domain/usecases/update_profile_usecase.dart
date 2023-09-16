import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/repositories/profile_repo.dart';

class UpdateProfileUseCase extends UseCase<ProfileEntity, ProfileModel> {
  final ProfileRepo repo;

  UpdateProfileUseCase(this.repo);
  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileModel params) {
    return repo.updateProfile(params);
  }
}
