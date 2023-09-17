import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:simsppob/features/transaction/data/models/transaction_history_model.dart';
import 'package:simsppob/features/transaction/domain/usecases/get_transaction_history.dart';

abstract class TransactionHistoryRemote {
  Future<TransactionHistoryResponseModel> getTransactionHistory(
      {required TransactionHistoryParam params, required String token});
}

class TransactionHistoryRemoteImpl implements TransactionHistoryRemote {
  @override
  Future<TransactionHistoryResponseModel> getTransactionHistory(
      {required TransactionHistoryParam params, required String token}) async {
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.get(
        Uri.parse(
            '${AppApi.transactionHistory}?offset=${params.offset}&limit=${params.limit}'),
        headers: header);
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return TransactionHistoryResponseModel.fromJson(
          json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
