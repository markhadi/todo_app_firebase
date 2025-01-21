import 'package:flutter/material.dart';

class Constants {
  static const String appTitle = 'To-Do App';
  static final ColorScheme colorScheme =
      ColorScheme.fromSeed(seedColor: Colors.blue);
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: Typography.material2021().black,
  );
}
