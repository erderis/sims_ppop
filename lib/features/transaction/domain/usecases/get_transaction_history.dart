import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/domain/repositories/transaction_repo.dart';

class GetTransactionHistoryUseCase
    extends UseCase<TransactionHistoryEntity, TransactionHistoryParam> {
  final TransactionRepo repo;

  GetTransactionHistoryUseCase(this.repo);
  @override
  Future<Either<Failure, TransactionHistoryEntity>> call(
      TransactionHistoryParam params) {
    return repo.getTransactionHistory(params);
  }
}

class TransactionHistoryParam extends Equatable {
  final int offset;
  final int limit;

  const TransactionHistoryParam({required this.offset, required this.limit});
  @override
  List<Object?> get props => [offset, limit];
}
