String? phoneValidator(String input) {
  final phoneExp = RegExp(r'[0-9]');
  if (input == "") {
    return "Заполните поле";
  } else if (phoneExp.hasMatch(input)) {
    return null;
  } else {
    return "Не верный формат номера";
  }
}
