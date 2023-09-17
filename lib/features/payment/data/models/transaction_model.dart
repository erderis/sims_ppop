import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/payment/domain/entities/transaction_entity.dart';

class TransactionResponseModel extends ResponseEntity {
  const TransactionResponseModel(
      {required super.status, required super.message, required super.data});

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      status: json['status'],
      message: json['message'],
      data: TransactionModel.fromJson(json['data']),
    );
  }
}

class TransactionModel extends TransactionEntity {
  const TransactionModel(
      {required super.invoiceNumber,
      required super.serviceCode,
      required super.serviceName,
      required super.transactionType,
      required super.totalAmount,
      required super.createdOn});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      invoiceNumber: json['invoice_number'],
      serviceCode: json['service_code'],
      serviceName: json['service_name'],
      transactionType: json['transaction_type'],
      totalAmount: json['total_amount'],
      createdOn: DateTime.parse(json['created_on']),
    );
  }
}
