String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? emailOrPhoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email or phone number';
  }

  // Check if it's a valid email
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (emailRegex.hasMatch(value)) {
    return null;
  }

  // Check if it's a valid phone number (digits only, length 10-15)
  final phoneRegex = RegExp(r'^[0-9+]+$');
  if (phoneRegex.hasMatch(value) && value.length >= 10 && value.length <= 15) {
    return null;
  }

  return 'Please enter a valid email or phone number';
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

// Confirm Password Validator
String? confirmPasswordValidator(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != originalPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  // Regular expression for validating international phone numbers
  String pattern =
      r'^\+?([0-9]{1,3})?[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,9})$';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}

//validation Name
String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }

  return null;
}

//validation Name
String? messageValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Message';
  }
  return null;
}

// Optional Phone Number Validator
String? validateOptionalPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  return null;
}
