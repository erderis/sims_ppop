import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/topup/domain/repositories/topup_repo.dart';

class TopUpUseCase extends UseCase<BalanceEntity, int> {
  final TopUpRepo repo;

  TopUpUseCase(this.repo);
  @override
  Future<Either<Failure, BalanceEntity>> call(int params) {
    return repo.topup(params);
  }
}
