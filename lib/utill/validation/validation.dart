String? validate(value, notificationText) {
  if (value == null || value.isEmpty) {
    return notificationText;
  }
  return null;
}
