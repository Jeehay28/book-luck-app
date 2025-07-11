import 'package:flutter/material.dart';

ButtonStyle kButtonActive = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.black),
  foregroundColor: WidgetStatePropertyAll(Colors.white),
  minimumSize: WidgetStatePropertyAll(Size(45, 32)),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

ButtonStyle kButtonInactive = ButtonStyle(
  minimumSize: WidgetStatePropertyAll(Size(45, 32)),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: Color(0xffEEEEEE),
        // your border color here
        width: 1, // border thickness
      ),
    ),
  ),
);
