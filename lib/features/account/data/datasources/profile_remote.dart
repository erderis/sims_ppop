import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

abstract class ProfileRemote {
  Future<ProfileResponseModel> getProfile(String token);
  Future<ProfileResponseModel> updateProfile(
      {required ProfileModel profileModel, required String token});
  Future<ProfileResponseModel> updateProfileImage(
      {required String filePath, required String token});
}

class ProfileRemoteImpl implements ProfileRemote {
  @override
  Future<ProfileResponseModel> getProfile(String token) async {
    Map<String, String> header = AppApi.header;
    header['Authorization'] = 'Bearer $token';
    final response = await http.get(Uri.parse(AppApi.profile), headers: header);
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return ProfileResponseModel.fromJson(json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileResponseModel> updateProfile(
      {required ProfileModel profileModel, required String token}) async {
    Map<String, String> header = AppApi.header;
    header['Authorization'] = 'Bearer $token';
    final response = await http.put(Uri.parse(AppApi.profileUpdate),
        headers: header, body: profileModel.toJson());
    print(response.statusCode);
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return ProfileResponseModel.fromJson(json.decode(response.body));
    } else if (statusCode == 401) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileResponseModel> updateProfileImage(
      {required String filePath, required String token}) async {
    Map<String, String> header = AppApi.headerFile;
    header['Authorization'] = 'Bearer $token';

    final body = dio.FormData.fromMap({});
    body.files.add(MapEntry(
        'file',
        await dio.MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last)));
    final dioInstace = dio.Dio();
    final response = await dioInstace.put(AppApi.profileImage,
        data: body, options: dio.Options(headers: header));

    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return ProfileResponseModel.fromJson(json.decode(response.data));
    } else if ([400, 401].contains(statusCode)) {
      final errorResponse = ErrorResponse.fromJson(json.decode(response.data));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
