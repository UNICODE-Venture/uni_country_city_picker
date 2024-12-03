import 'dart:async';
import 'package:flutter/material.dart';

class UniStyle {
  //* Singleton __________________________________
  UniStyle._();
  static UniStyle? _instance;
  static final _lock = Completer<void>();

  static UniStyle get instance {
    if (_instance == null) {
      if (!_lock.isCompleted) _lock.complete();
      _instance = UniStyle._();
    }
    return _instance!;
  }

  static Color loud900 = const Color(0xFF10100F);
  static Color normal25 = const Color(0xFFF8F8F8);
  static Color normal500 = const Color(0xFF79746D);
  static Color darkGreen = const Color(0xFF484D46);
  static Color muted600 = const Color(0xFF43403D);
  static Color primary100 = const Color(0xFFCB9D57);
  static Color disabled25 = const Color(0xFFF8F8F8);

  static TextStyle get s_14_400 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s_15_400 => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s_16_400 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
}
