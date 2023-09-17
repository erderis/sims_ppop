import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/topup/domain/usecases/topup_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class TopUpProvider extends ChangeNotifier {
  final TopUpUseCase topUpUseCase;

  DataState _dataState = DataState();

  TopUpProvider(this.topUpUseCase);

  DataState get dataState => _dataState;

  Future<void> topUp(int param) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrTopUp = await topUpUseCase(param);
    failureOrTopUp.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }
}
