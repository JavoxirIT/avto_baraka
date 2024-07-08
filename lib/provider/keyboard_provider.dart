import 'package:flutter/material.dart';

class KeyboardVisibilityController with ChangeNotifier, WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  KeyboardVisibilityController() {
    WidgetsBinding.instance.addObserver(this);
  }

  bool get isKeyboardVisible => _isKeyboardVisible;

  void updateKeyboardVisibility(BuildContext context) {
    final isKeyboardVisible = View.of(context).viewInsets.bottom >= 0.0;
    if (_isKeyboardVisible != isKeyboardVisible) {
      _isKeyboardVisible = isKeyboardVisible;
      notifyListeners();
    }
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
