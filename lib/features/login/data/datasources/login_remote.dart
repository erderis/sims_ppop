import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:simsppob/features/login/data/models/login_response_model.dart';

abstract class LoginRemote {
  Future<LoginResponseModel> login(LoginModel loginModel);
}

class LoginRemoteImpl implements LoginRemote {
  @override
  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse(AppApi.login),
      body: loginModel.toJson(),
    );
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final loginResponse =
          LoginResponseModel.fromJson(json.decode(response.body));
      return Future.value(loginResponse);
    } else if ([400, 401].contains(statusCode)) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
