// email_validator.dart

bool isValidEmail(String email) {
  // Regular expression for email validation
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Use the RegExp's hasMatch method to check if the email matches the pattern
  return emailRegex.hasMatch(email);
}
