import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/payment/domain/entities/transaction_entity.dart';
import 'package:simsppob/features/payment/domain/usecases/transaction_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class PaymentProvider extends ChangeNotifier {
  final TransactionUseCase transactionUseCase;

  DataState<TransactionEntity> _dataState = DataState<TransactionEntity>();

  PaymentProvider(this.transactionUseCase);

  DataState<TransactionEntity> get dataState => _dataState;

  Future<void> transaction(String param) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrTransaction = await transactionUseCase(param);
    failureOrTransaction.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }
}
