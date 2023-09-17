import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class TransactionProvider extends ChangeNotifier {
  final GetTransactionHistoryUseCase getTransactionHistoryUseCase;

  DataState<TransactionHistoryEntity> _dataState =
      DataState<TransactionHistoryEntity>();

  TransactionProvider(this.getTransactionHistoryUseCase);

  DataState<TransactionHistoryEntity> get dataState => _dataState;

  Future<void> getTransactionHistory(TransactionHistoryParam params) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrTransactionHistory =
        await getTransactionHistoryUseCase(params);
    failureOrTransactionHistory.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (transactionHistory) =>
            _dataState = DataState(isSuccess: true, data: transactionHistory));
    notifyListeners();
  }
}
