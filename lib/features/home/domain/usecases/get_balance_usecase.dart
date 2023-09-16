import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/home/domain/repositories/home_repo.dart';

class GetBalanceUseCase extends UseCase<BalanceEntity, NoParams> {
  final HomeRepo repo;

  GetBalanceUseCase(this.repo);
  @override
  Future<Either<Failure, BalanceEntity>> call(NoParams params) {
    return repo.getBalance();
  }
}
