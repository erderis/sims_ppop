import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/login/data/models/login_model.dart';
import 'package:simsppob/features/login/domain/usecases/delete_last_login_usecase.dart';
import 'package:simsppob/features/login/domain/usecases/get_last_login_usacase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class LastLoginProvider extends ChangeNotifier {
  final GetLastLoginUseCase getLastLoginUseCase;
  final DeleteLastLoginUseCase deleteLastLoginUseCase;

  DataState _dataState = DataState();

  LastLoginProvider(this.getLastLoginUseCase, this.deleteLastLoginUseCase);

  DataState get dataState => _dataState;

  Future<void> appStarted() async {
    _dataState = DataState(isLoading: true);
    notifyListeners();
    final failureOrLastLogin = await getLastLoginUseCase(NoParams());
    failureOrLastLogin.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }

  Future<void> logout() async {
    _dataState = DataState(isLoading: true);
    notifyListeners();
    final failureOrLogout = await deleteLastLoginUseCase(NoParams());
    failureOrLogout.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }
}
