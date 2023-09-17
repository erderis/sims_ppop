import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:simsppob/features/home/data/models/services_model.dart';

abstract class ServicesRemote {
  Future<ServicesResponseModel> getServices(String token);
}

class ServicesRemoteImpl implements ServicesRemote {
  @override
  Future<ServicesResponseModel> getServices(String token) async {
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(AppApi.services), headers: header);
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return ServicesResponseModel.fromJson(json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
