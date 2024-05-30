import 'dart:math';

import 'package:flutter/services.dart';

class ColorNote{
  ColorNote._();
  
  static final List<String> _colorHexList = [
    '0xFFEEEDE1',
    '0xFFE4D8E0',
    '0xFFFBECD',
    '0xFFECF3DC',
    '0xFFB7C6E6',
    '0xFFCFC6B0',
    '0xFFF0ECD8',
  ];

  static final Random _random = Random();

  static String randomColorHex(){
    return _colorHexList[_random.nextInt(_colorHexList.length)];
  }
}