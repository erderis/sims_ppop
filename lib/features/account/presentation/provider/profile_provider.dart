import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/usecases/get_profile_usecase.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_image_usecase.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileState<ProfileEntity> _dataState = ProfileState<ProfileEntity>();

  ProfileProvider(this.getProfileUseCase, this.updateProfileImageUseCase,
      this.updateProfileUseCase);

  ProfileState<ProfileEntity> get dataState => _dataState;

  Future<void> getProfile({bool isWithLoading = true}) async {
    if (isWithLoading) {
      _dataState = ProfileState(isLoading: true);
    }
    notifyListeners();

    final failureOrProfile = await getProfileUseCase(NoParams());
    failureOrProfile.fold(
        (failure) => _dataState =
            ProfileState(isError: true, error: mapFailureToMessage(failure)),
        (profile) {
      _dataState = ProfileState(isSuccess: true, data: profile);
    });
    notifyListeners();
  }

  Future<void> updateProfile(
      {required ProfileModel profileModel,
      required ProfileEntity currentData}) async {
    _dataState =
        ProfileState(isSuccess: true, isLoadingUpdate: true, data: currentData);
    notifyListeners();

    final failureOrProfile = await updateProfileUseCase(profileModel);
    failureOrProfile.fold(
        (failure) => _dataState = ProfileState(
            isErrorUpdate: true,
            isSuccess: true,
            error: mapFailureToMessage(failure),
            data: currentData), (profile) {
      _dataState =
          ProfileState(isSuccess: true, isSuccessUpdate: true, data: profile);
    });
    notifyListeners();
  }

  void pickImage(BuildContext context, {required ProfileEntity currentData}) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        final File imageFile = File(image.path);
        final String fileExtension = image.path.split('.').last.toLowerCase();

        if (fileExtension == 'jpg' ||
            fileExtension == 'jpeg' ||
            fileExtension == 'png') {
          imageFile.length().then((fileSizeInBytes) {
            if (fileSizeInBytes <= 100 * 1024) {
              updateProfileImage(
                  filePath: image.path, currentData: currentData);
            } else {
              showAppToast(context,
                  message: 'Ukuran maksimal gambar adalah 100kb');
            }
          });
        } else {
          showAppToast(context,
              message: 'Hanya file JPG, JPEG dan PNG yang diterima');
        }
      }
    });
  }

  Future<void> updateProfileImage(
      {required String filePath, required ProfileEntity currentData}) async {
    _dataState =
        ProfileState(isSuccess: true, isLoadingImage: true, data: currentData);
    notifyListeners();
    final failureOrProfile = await updateProfileImageUseCase(filePath);
    failureOrProfile.fold(
        (failure) => _dataState = ProfileState(
            isErrorImage: true,
            isSuccess: true,
            error: mapFailureToMessage(failure),
            data: currentData),
        (profile) => _dataState = ProfileState(isSuccess: true, data: profile));
    notifyListeners();
  }

  Future<void> resetProfileState({required ProfileEntity currentData}) async {
    _dataState = ProfileState(isSuccess: true, data: currentData);
    notifyListeners();
  }
}
