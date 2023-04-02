class Validator {
  static String? validateEmail(String? value) {
    const Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern as String);
    if (!regex.hasMatch(value ?? '')) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateText(String? value, String? label) {
    if (value == null || value.isEmpty) {
      return '$label cannot be empty';
    } else {
      return null;
    }
  }
}
