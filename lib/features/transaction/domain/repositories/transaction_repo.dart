import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';

abstract class TransactionRepo {
  Future<Either<Failure, TransactionHistoryEntity>> getTransactionHistory(
      TransactionHistoryParam params);
}
