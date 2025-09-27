class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'البريد مطلوب';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'بريد إلكتروني غير صالح';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
    return null;
  }
}