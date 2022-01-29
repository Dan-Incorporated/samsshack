/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/keys.dart';
import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/widgets/dialogs/dialog_base.dart';

/// ==============================================================================
/// DIALOG BASE ==================================================================
/// ==============================================================================

Future<dynamic> dialogBasic(
  BuildContext context, {
  required String title,
  required List<Widget> children,
  Color? colorTextTitle,
  Color? colorTextClose,
}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBase(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).primaryColor),
          ),
          content: SizedBox(
            height: measureScreenHeight(context) * 0.4,
            width: measureScreenWidth(context) * 0.8,
            child: ListView(
              children: children,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Close",
                key: keyWidgetsDialogBaseButtonClose,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

/// ==============================================================================
/// DIALOG GENERIC INFO ==========================================================
/// ==============================================================================

Future<dynamic> dialogBaseInfo(BuildContext context, {required String title, String subtitle = ""}) {
  return dialogBasic(context, title: title, children: <Widget>[
    Text(
      subtitle,
    ),
  ]);
}
