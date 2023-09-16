import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';

class BalanceResponseModel extends ResponseEntity {
  const BalanceResponseModel(
      {required super.status, required super.message, required super.data});

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) {
    return BalanceResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class BalanceModel extends BalanceEntity {
  const BalanceModel({required super.balance});

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(balance: json['balance']);
  }
}
