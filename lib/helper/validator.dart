bool isEmailValid(String email) {
  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );
  return emailRegex.hasMatch(email);
}