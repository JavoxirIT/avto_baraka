import 'package:flutter/material.dart';

class KeyboardVisibilityController with ChangeNotifier, WidgetsBindingObserver {
  bool _isKeyboardVisible = false;
  // FocusNode? _focusNode;

  KeyboardVisibilityController() {
    WidgetsBinding.instance.addObserver(this);
  }

  bool get isKeyboardVisible => _isKeyboardVisible;

  set focusNode(FocusNode? focusNode) {
    // _focusNode = focusNode;
  }

  void updateKeyboardVisibility(BuildContext context) {
    final isKeyboardVisible = View.of(context).viewInsets.bottom > 0.0;
    if (_isKeyboardVisible != isKeyboardVisible) {
      _isKeyboardVisible = isKeyboardVisible;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
