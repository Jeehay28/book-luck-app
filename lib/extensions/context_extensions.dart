import 'package:flutter/material.dart';

extension ScreenDimensions on BuildContext {
  double get bodyHeight =>
      MediaQuery.of(this).size.height -
      MediaQuery.of(this).padding.top // Exclude SafeArea top padding
      -
      MediaQuery.of(this).padding.bottom; // Exclude SafeArea bottom padding

  double get bodyWidth =>
      MediaQuery.of(this).size.width -
      MediaQuery.of(this).padding.left - // Exclude SafeArea left padding
      MediaQuery.of(this).padding.right; // Exclude Sa
}
