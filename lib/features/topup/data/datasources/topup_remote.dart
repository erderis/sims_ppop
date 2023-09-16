import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/home/data/models/balance_model.dart';
import 'package:http/http.dart' as http;

abstract class TopUpRemote {
  Future<BalanceResponseModel> topUp(
      {required int amount, required String token});
}

class TopUpRemoteImpl implements TopUpRemote {
  @override
  Future<BalanceResponseModel> topUp(
      {required int amount, required String token}) async {
    Map<String, String> header = AppApi.header;
    header['Authorization'] = 'Bearer $token';
    final response = await http.post(Uri.parse(AppApi.topup),
        headers: header, body: {"top_up_amount": amount});
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return BalanceResponseModel.fromJson(json.decode(response.body));
    } else if ([400, 401].contains(statusCode)) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
