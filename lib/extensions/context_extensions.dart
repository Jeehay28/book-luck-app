import 'package:flutter/material.dart';

extension ScreenDimensions on BuildContext {
  double get bodyHeight {
    // Calculate total screen height excluding system top/bottom padding (safe area)
    double safeAreaHeight = MediaQuery.of(this).size.height -
        MediaQuery.of(this)
            .padding
            .top - // Exclude SafeArea top padding (status bar, notch)
        MediaQuery.of(this)
            .padding
            .bottom; // Exclude SafeArea bottom padding (system navigation bar/gestures)

    return safeAreaHeight - kBottomNavigationBarHeight;
  }

  double get bodyWidth =>
      MediaQuery.of(this).size.width -
      MediaQuery.of(this).padding.left - // Exclude SafeArea left padding
      MediaQuery.of(this).padding.right; // Exclude Sa
}
