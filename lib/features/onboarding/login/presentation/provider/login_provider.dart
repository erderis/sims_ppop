import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/onboarding/login/data/models/login_model.dart';
import 'package:simsppob/features/onboarding/login/domain/usecases/login_usacase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  DataState _dataState = DataState();

  LoginProvider(this.loginUseCase);

  DataState get dataState => _dataState;

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
