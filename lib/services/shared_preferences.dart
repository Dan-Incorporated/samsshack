/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:samsshack/services/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  /// ==========================/
  ///
  /// CONST
  ///
  final String sharedPrefToken = "token";
  final String sharedPrefDarkMode = "dark-mode";

  /// =========================================================================================/
  /// TOKEN FUNCTIONS =========================================================================/
  /// =========================================================================================/

  Future<String> prefGetToken() async {
    if (!isTestMode()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(sharedPrefToken) ?? "";
    } else {
      return "";
    }
  }

  Future<bool> prefSaveToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(sharedPrefToken, value);
  }

  /// =========================================================================================/
  /// DARK MODE FUNCTIONS =====================================================================/
  /// =========================================================================================/

  Future<bool> prefGetDarkMode() async {
    if (!isTestMode()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(sharedPrefDarkMode) ?? false;
    } else {
      return false;
    }
  }

  Future<bool> prefSaveDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(sharedPrefDarkMode, value);
  }

}