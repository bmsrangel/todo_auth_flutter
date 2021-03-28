class ValidationFailedException implements Exception {
  ValidationFailedException(this.message);

  final String message;
}
