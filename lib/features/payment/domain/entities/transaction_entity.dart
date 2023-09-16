import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String invoiceNumber;
  final String serviceCode;
  final String serviceName;
  final String transactionType;
  final int totalAmount;
  final DateTime createdOn;

  const TransactionEntity({
    required this.invoiceNumber,
    required this.serviceCode,
    required this.serviceName,
    required this.transactionType,
    required this.totalAmount,
    required this.createdOn,
  });

  @override
  List<Object?> get props => [
        invoiceNumber,
        serviceCode,
        serviceName,
        transactionType,
        totalAmount,
        createdOn
      ];
}
