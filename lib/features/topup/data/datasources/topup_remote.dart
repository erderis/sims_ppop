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
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final Map<String, dynamic> requestBody = {
      "top_up_amount": amount,
    };

    final String requestBodyJson = jsonEncode(requestBody);
    final response = await http.post(
      Uri.parse(AppApi.topup),
      headers: {
        'Content-Type': 'application/json', // Set content type to JSON
        ...header,
      },
      body: requestBodyJson,
    );
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
