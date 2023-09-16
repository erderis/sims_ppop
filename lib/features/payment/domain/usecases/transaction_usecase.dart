import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/payment/domain/entities/transaction_entity.dart';
import 'package:simsppob/features/payment/domain/repositories/payment_repo.dart';

class TransactionUseCase extends UseCase<TransactionEntity, String> {
  final PaymentRepo repo;

  TransactionUseCase(this.repo);
  @override
  Future<Either<Failure, TransactionEntity>> call(String params) {
    return repo.transaction(params);
  }
}
