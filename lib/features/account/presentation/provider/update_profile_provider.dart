import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class UpdateProfileProvider extends ChangeNotifier {
  final UpdateProfileUseCase updateProfileUseCase;

  DataState<ProfileEntity> _dataState = DataState<ProfileEntity>();

  UpdateProfileProvider(this.updateProfileUseCase);

  DataState<ProfileEntity> get dataState => _dataState;

  Future<void> updateProfile(ProfileModel profileModel) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrProfile = await updateProfileUseCase(profileModel);
    failureOrProfile.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (profile) => _dataState = DataState(isSuccess: true, data: profile));
    notifyListeners();
  }
}
