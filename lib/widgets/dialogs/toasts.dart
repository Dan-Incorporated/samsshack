/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// ==============================================================================
/// TOAST BASE ===================================================================
/// ==============================================================================

Future<void> toastBase(
  BuildContext context, {
  required String message,
  Toast toastLength = Toast.LENGTH_SHORT,
}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
