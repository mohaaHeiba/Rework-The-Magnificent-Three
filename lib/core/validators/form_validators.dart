class FormValidators {
  String? nameValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Please enter your name.';
    }
    if (value.length < 3) {
      return 'name must be at least 3 characters long.';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Please enter your name.';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }
}
