class ErrorResponse {
  final String message;
  final Map<String, dynamic>? errors;
  final String? error;

  ErrorResponse({
    required this.message,
    this.errors,
    this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      errors: json['errors'],
      error: json['error'],
    );
  }
}
