import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/home/domain/repositories/home_repo.dart';

class GetServicesUseCase extends UseCase<List<ServiceEntity>, NoParams> {
  final HomeRepo repo;

  GetServicesUseCase(this.repo);
  @override
  Future<Either<Failure, List<ServiceEntity>>> call(NoParams params) {
    return repo.getServices();
  }
}
