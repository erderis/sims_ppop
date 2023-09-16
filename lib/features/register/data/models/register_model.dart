import 'package:simsppob/features/register/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel(
      {required super.email,
      required super.firstName,
      required super.lastName,
      required super.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };
  }
}
