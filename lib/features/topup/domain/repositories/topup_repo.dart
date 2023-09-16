import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';

abstract class TopUpRepo {
  Future<Either<Failure, BalanceEntity>> topup(int params);
}
