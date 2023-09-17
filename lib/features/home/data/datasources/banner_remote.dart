import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/home/data/models/banner_model.dart';
import 'package:http/http.dart' as http;

abstract class BannerRemote {
  Future<BannerResponseModel> getBanner(String token);
}

class BannerRemoteImpl implements BannerRemote {
  @override
  Future<BannerResponseModel> getBanner(String token) async {
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(AppApi.banner), headers: header);
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return BannerResponseModel.fromJson(json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
