import 'package:supos_v3/utils/constants/app_strings.dart';

class FormValidators {
  final String? fieldName;

  FormValidators(this.fieldName);
  //field name is optional
  //field Name default validator
  // Email validator
  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  static String? noValidation(String? value) {
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterName;
    }
    final nameRegex =
        RegExp(AppStrings.nameRegexp, caseSensitive: false, multiLine: false);
    if (!nameRegex.hasMatch(value)) {
      return AppStrings.invalidName;
    }
    return null;
  }

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
