import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/usecases/get_profile_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfileUseCase getProfileUseCase;

  DataState<ProfileEntity> _dataState = DataState<ProfileEntity>();

  ProfileProvider(this.getProfileUseCase);

  DataState<ProfileEntity> get dataState => _dataState;

  Future<void> getProfile({bool isWithLoading = true}) async {
    if (isWithLoading) {
      _dataState = DataState(isLoading: true);
    }
    notifyListeners();

    final failureOrProfile = await getProfileUseCase(NoParams());
    failureOrProfile.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (profile) => _dataState = DataState(isSuccess: true, data: profile));
    notifyListeners();
  }
}
