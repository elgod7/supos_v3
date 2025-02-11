import 'package:supos_v3/utils/constants/app_strings.dart';

class FormValidators {
  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex =
        RegExp(AppStrings.emailRegexp, caseSensitive: false, multiLine: false);
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.invalidEmailAddress;
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordIsShort;
    }
    return null;
  }

  // Confirm password validator
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (value != password) {
      return AppStrings.passwordNotMatched;
    }
    return null;
  }
}
