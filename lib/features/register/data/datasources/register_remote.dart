import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/register/data/models/register_model.dart';
import 'package:http/http.dart' as http;

abstract class RegisterRemote {
  Future<void> register(RegisterModel registerModel);
}

class RegisterRemoteImpl implements RegisterRemote {
  @override
  Future<void> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse(AppApi.registration),
      body: registerModel.toJson(),
    );
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return Future.value();
    } else if (statusCode == 400) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
