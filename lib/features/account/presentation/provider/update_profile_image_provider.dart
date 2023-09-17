import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_image_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class UpdateProfileImageProvider extends ChangeNotifier {
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  DataState<ProfileEntity> _dataState = DataState<ProfileEntity>();

  UpdateProfileImageProvider(this.updateProfileImageUseCase);

  DataState<ProfileEntity> get dataState => _dataState;

  Future<void> updateProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpeg', 'png'],
    );

    if (result != null) {
      _dataState = DataState(isLoading: true);
      notifyListeners();

      final failureOrProfile =
          await updateProfileImageUseCase(result.files.first.path!);
      failureOrProfile.fold(
          (failure) => _dataState =
              DataState(isError: true, error: mapFailureToMessage(failure)),
          (profile) => _dataState = DataState(isSuccess: true, data: profile));
      notifyListeners();
    }
  }
}
