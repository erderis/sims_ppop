import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  const ProfileEntity({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage = '',
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image'],
    );
  }

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        profileImage,
      ];
}
