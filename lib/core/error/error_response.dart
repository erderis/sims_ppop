import 'package:simsppob/core/response/response_model.dart';

class ErrorResponse extends ResponseEntity {
  const ErrorResponse(
      {required super.status, required super.message, required super.data});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
