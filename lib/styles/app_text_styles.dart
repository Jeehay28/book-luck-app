import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';

TextStyle _baseTextStyle(BuildContext context, double fontSize,
    {double opacity = 1.0,
    Color color = const Color(0xFF303030),
    FontWeight weight = FontWeight.w700}) {
  final width = context.bodyWidth;
  return TextStyle(
    color: color.withAlpha((opacity.clamp(0, 1.0) * 255).round()),
    fontSize: width * (fontSize / 360),
    fontWeight: weight,
    height: 1.5,
    letterSpacing: -0.32,
  );
}

TextStyle kTextStyle12(BuildContext context,
        {double opacity = 1.0,
        Color color = const Color(0xFF303030),
        FontWeight weight = FontWeight.w700}) =>
    _baseTextStyle(context, 12, opacity: opacity, color: color, weight: weight);

TextStyle kTextStyle14(BuildContext context,
        {double opacity = 1.0,
        Color color = const Color(0xFF303030),
        FontWeight weight = FontWeight.w700}) =>
    _baseTextStyle(context, 14, opacity: opacity, color: color, weight: weight);

TextStyle kTextStyle16(BuildContext context,
        {double opacity = 1.0,
        Color color = const Color(0xFF303030),
        FontWeight weight = FontWeight.w700}) =>
    _baseTextStyle(context, 16, opacity: opacity, color: color, weight: weight);

TextStyle kTextStyle18(BuildContext context,
        {double opacity = 1.0,
        Color color = const Color(0xFF303030),
        FontWeight weight = FontWeight.w700}) =>
    _baseTextStyle(context, 18, opacity: opacity, color: color, weight: weight);

TextStyle kTextStyle24(BuildContext context,
        {double opacity = 1.0,
        Color color = const Color(0xFF303030),
        FontWeight weight = FontWeight.w700}) =>
    _baseTextStyle(context, 24, opacity: opacity, color: color, weight: weight);
