import 'package:dartz/dartz.dart';
import 'package:simsppob/core/error/failure.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/home/domain/entities/banner_entity.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerEntity>>> getBanner();
  Future<Either<Failure, List<ServiceEntity>>> getServices();
  Future<Either<Failure, BalanceEntity>> getBalance();
}
