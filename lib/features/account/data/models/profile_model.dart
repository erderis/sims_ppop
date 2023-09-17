import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';

class ProfileResponseModel extends ResponseEntity {
  const ProfileResponseModel(
      {required super.status, required super.message, required super.data});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      status: json['status'],
      message: json['message'],
      data: ProfileModel.fromJson(json['data']),
    );
  }
}

class ProfileModel extends ProfileEntity {
  const ProfileModel(
      {required super.email,
      required super.firstName,
      required super.lastName,
      super.profileImage});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
