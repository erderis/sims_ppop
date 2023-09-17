import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/balance_entity.dart';
import 'package:simsppob/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class BalanceProvider extends ChangeNotifier {
  final GetBalanceUseCase getBalanceUseCase;

  DataState<BalanceEntity> _dataState = DataState<BalanceEntity>();

  BalanceProvider(this.getBalanceUseCase);

  DataState<BalanceEntity> get dataState => _dataState;

  Future<void> getBalance() async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrBalance = await getBalanceUseCase(NoParams());
    failureOrBalance.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (balance) => _dataState = DataState(isSuccess: true, data: balance));
    notifyListeners();
  }
}
