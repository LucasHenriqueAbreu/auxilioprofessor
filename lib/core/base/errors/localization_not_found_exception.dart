class LocalizationNotFoundException implements Exception {
  final String message;

  LocalizationNotFoundException([this.message = 'Localization']);

  @override
  String toString() {
    return message;
  }
}
