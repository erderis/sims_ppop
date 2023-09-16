import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/login/data/models/login_model.dart';
import 'package:simsppob/features/login/domain/usecases/login_usacase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class LoginProvider<T> extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  DataState<T> _dataState = DataState<T>();

  LoginProvider(this.loginUseCase);

  DataState<T> get dataState => _dataState;

  Future<void> login(LoginModel loginModel) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrLogin = await loginUseCase(loginModel);
    failureOrLogin.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }
}
