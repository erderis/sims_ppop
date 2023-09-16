import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';

class TransactionHistoryResponseModel extends ResponseEntity {
  const TransactionHistoryResponseModel(
      {required super.status, required super.message, required super.data});

  factory TransactionHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class TransactionHistoryModel extends TransactionHistoryEntity {
  const TransactionHistoryModel(
      {required super.offset, required super.limit, required super.records});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonRecords = json['records'];
    final List<TransactionHistoryRecordModel> recordList = jsonRecords
        .map((record) => TransactionHistoryRecordModel.fromJson(record))
        .toList();

    return TransactionHistoryModel(
      offset: json['offset'],
      limit: json['limit'],
      records: recordList,
    );
  }
}

class TransactionHistoryRecordModel extends TransactionHistoryRecordEntity {
  const TransactionHistoryRecordModel(
      {required super.invoiceNumber,
      required super.transactionType,
      required super.description,
      required super.totalAmount,
      required super.createdOn});

  factory TransactionHistoryRecordModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryRecordModel(
      invoiceNumber: json['invoice_number'],
      transactionType: json['transaction_type'],
      description: json['description'],
      totalAmount: json['total_amount'],
      createdOn: DateTime.parse(json['created_on']),
    );
  }
}
