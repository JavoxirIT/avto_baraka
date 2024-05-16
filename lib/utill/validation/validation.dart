String? validate(value, notificationText) {
  if (value == null || value == "") {
    return notificationText;
  }
  return null;
}
