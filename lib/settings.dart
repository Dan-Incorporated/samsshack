/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';

/// =============================================================================
/// SETTINGS ====================================================================
/// =============================================================================

/// ================================= //
///
/// THEME
///


// TODO - customize theme data

// EXTRA COLOR PALETTE
final Color colorGreen = Colors.green[400]!;
final Color colorRed = Colors.red[400]!;
final Color colorYellow = Colors.yellow[800]!;
final Color colorGrey = Colors.grey[500]!;
final Color colorSecondary = Colors.orangeAccent[400]!;

// FONT
const String fontFamilyDefault = 'Pacifico';

// light theme
ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue[700],
  primaryColorLight: Colors.blue[200],
  primaryColorDark: Colors.blue[900],
  splashColor: Colors.blue[100],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: fontFamilyDefault,
);

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: themeLight.primaryColor,
  primaryColorLight: themeLight.primaryColorLight,
  primaryColorDark: themeLight.primaryColorDark,
  splashColor: themeLight.splashColor,
  fontFamily: fontFamilyDefault,
);

/// ================================= //
///
/// ENVIRONMENT
///
enum ENV_OPTIONS {
  dev,
  prod,
  stage,
  test,
}
