import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/payment/domain/entities/transaction_entity.dart';

abstract class PaymentRepo {
  Future<Either<Failure, TransactionEntity>> transaction(String params);
}
