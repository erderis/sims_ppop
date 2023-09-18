import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/onboarding/register/data/models/register_model.dart';
import 'package:simsppob/features/onboarding/register/domain/usecases/register_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  DataState _dataState = DataState();

  RegisterProvider(this.registerUseCase);

  DataState get dataState => _dataState;

  Future<void> register(RegisterModel registerModel) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrRegister = await registerUseCase(registerModel);
    failureOrRegister.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (_) => _dataState = DataState(isSuccess: true));
    notifyListeners();
  }
}
