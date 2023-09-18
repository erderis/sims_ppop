import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/home/data/models/balance_model.dart';
import 'package:http/http.dart' as http;

abstract class BalanceRemote {
  Future<BalanceResponseModel> getBalance(String token);
}

class BalanceRemoteImpl implements BalanceRemote {
  @override
  Future<BalanceResponseModel> getBalance(String token) async {
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(AppApi.balance), headers: header);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return BalanceResponseModel.fromJson(json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
