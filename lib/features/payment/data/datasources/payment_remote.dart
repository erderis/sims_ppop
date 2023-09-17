import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:simsppob/features/payment/data/models/transaction_model.dart';

abstract class PaymentRemote {
  Future<TransactionResponseModel> transaction(
      {required String serviceCode, required String token});
}

class PaymentRemoteImpl implements PaymentRemote {
  @override
  Future<TransactionResponseModel> transaction(
      {required String serviceCode, required String token}) async {
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(AppApi.transaction),
        headers: header, body: {"service_code": serviceCode});
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return TransactionResponseModel.fromJson(json.decode(response.body));
    } else if ([400, 401].contains(statusCode)) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
