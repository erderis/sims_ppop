import 'package:equatable/equatable.dart';

class TransactionHistoryEntity extends Equatable {
  final String offset;
  final String limit;
  final List<TransactionHistoryRecordEntity> records;

  const TransactionHistoryEntity({
    required this.offset,
    required this.limit,
    required this.records,
  });

  @override
  List<Object?> get props => [offset, limit, records];
}

class TransactionHistoryRecordEntity extends Equatable {
  final String invoiceNumber;
  final String transactionType;
  final String description;
  final int totalAmount;
  final DateTime createdOn;

  const TransactionHistoryRecordEntity({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  @override
  List<Object?> get props =>
      [invoiceNumber, transactionType, description, totalAmount, createdOn];
}
