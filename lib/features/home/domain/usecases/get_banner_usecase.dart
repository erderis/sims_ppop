import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/banner_entity.dart';
import 'package:simsppob/features/home/domain/repositories/home_repo.dart';

class GetBannerUseCase extends UseCase<List<BannerEntity>, NoParams> {
  final HomeRepo repo;

  GetBannerUseCase(this.repo);
  @override
  Future<Either<Failure, List<BannerEntity>>> call(NoParams params) {
    return repo.getBanner();
  }
}
