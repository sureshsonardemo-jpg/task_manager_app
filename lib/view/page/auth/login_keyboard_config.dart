class LoginKeyboardConfig {
  const LoginKeyboardConfig._();

  static const bool resizeToAvoidBottomInset = true;
  static const double focusedFieldScrollPadding = 24;

  static double bottomPadding(double keyboardInset) {
    return keyboardInset > 0 ? focusedFieldScrollPadding : 0;
  }
}
