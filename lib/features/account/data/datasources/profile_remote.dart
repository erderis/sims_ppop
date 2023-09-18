import 'dart:convert';

import 'package:simsppob/constants/api.dart';
import 'package:simsppob/core/error/error_response.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/features/account/data/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(AppApi.profile), headers: header);
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
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    final response = await http.put(Uri.parse(AppApi.profileUpdate),
        headers: header, body: profileModel.toJson());
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
    final uri = Uri.parse(AppApi.profileImage);

    final request = http.MultipartRequest('PUT', uri);

    request.headers['Authorization'] = 'Bearer $token';

    // Create a MultipartFile from the image file
    final fileExtension = filePath.split('.').last.toLowerCase();
    final mediaType = fileExtension == 'jpg' || fileExtension == 'jpeg'
        ? MediaType('image', 'jpeg')
        : fileExtension == 'png'
            ? MediaType('image', 'png')
            : null;

    final file = await http.MultipartFile.fromPath(
      'file',
      filePath,
      contentType: mediaType,
    );
    // Add the file to the request
    request.files.add(file);
    final response = await request.send();
    final responseBodyStream = response.stream;
    final List<int> byteData = [];
    await responseBodyStream.forEach((chunk) {
      byteData.addAll(chunk);
    });

    final statusCode = response.statusCode;
    final responseBody = utf8.decode(byteData);
    if (statusCode == 200) {
      return ProfileResponseModel.fromJson(json.decode(responseBody));
    } else if ([400, 401].contains(statusCode)) {
      final errorResponse = ErrorResponse.fromJson(json.decode(responseBody));
      throw ServerException(errorResponse: errorResponse);
    } else {
      throw ServerException();
    }
  }
}
