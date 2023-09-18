import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/transaction/domain/entities/transaction_history_entity.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class TransactionProvider extends ChangeNotifier {
  final GetTransactionHistoryUseCase getTransactionHistoryUseCase;

  DataState<TransactionHistoryEntity> _dataState =
      DataState<TransactionHistoryEntity>();

  List<TransactionHistoryRecordEntity> _transactionList =
      []; // Maintain the list of transactions.
  int _offset = 0;
  final int _limit = 5;
  bool isLoadMoreLoading = false;

  TransactionProvider(this.getTransactionHistoryUseCase);

  DataState<TransactionHistoryEntity> get dataState => _dataState;

  Future<void> getTransactionHistory({bool isWithLoading = true}) async {
    if (isWithLoading) {
      _dataState = DataState(isLoading: true);
    }
    notifyListeners();

    final failureOrTransactionHistory = await getTransactionHistoryUseCase(
        TransactionHistoryParam(offset: _offset, limit: _limit));
    failureOrTransactionHistory.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (transactionHistory) {
      _dataState = DataState(isSuccess: true, data: transactionHistory);
      _transactionList = transactionHistory.records;
    });
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_dataState.isSuccess) {
      isLoadMoreLoading = true;
      notifyListeners();
      final params =
          TransactionHistoryParam(offset: _offset + _limit, limit: _limit);
      final failureOrTransactionHistory =
          await getTransactionHistoryUseCase(params);
      failureOrTransactionHistory.fold(
        (_) {},
        (transactionHistory) {
          _offset += transactionHistory.records.length;
          _transactionList.addAll(transactionHistory.records);
        },
      );
      isLoadMoreLoading = false;
      notifyListeners();
    }
  }
}
