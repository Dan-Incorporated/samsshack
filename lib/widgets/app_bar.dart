/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/main.dart';
import 'package:samsshack/services/shared_preferences.dart';
import 'package:samsshack/struc/base_state.dart';

/// =================================================================================
/// APP BAR =========================================================================
/// =================================================================================

class AppBarBase extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final Color colorTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? colorBackground;

  const AppBarBase({
    Key? key,
    this.title = "Sams Shack",
    this.colorTitle = Colors.white,
    this.actions,
    this.leading,
    this.colorBackground,
  }) : super(key: key);

  @override
  _AppBarBaseState createState() => _AppBarBaseState();

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}

class _AppBarBaseState extends BaseState<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    bool isDark = darkNotifier.value;
    Color colorBg = widget.colorBackground ?? Theme.of(context).primaryColor;
    // get default action if nothing passed
    List<Widget>? tmpActions = widget.actions;
    if (tmpActions == null || tmpActions.isEmpty) {
      tmpActions = <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: InkWell(
              onTap: () {
                setState(() {
                  isDark = !isDark;
                  darkNotifier.value = isDark;
                  Preferences().prefSaveDarkMode(darkNotifier.value);
                });
              },
              child: Icon(!isDark ? Icons.wb_sunny : Icons.wb_sunny_outlined, size: 20.0)),
        )
      ];
    }

    return AppBar(
      actions: tmpActions,
      backgroundColor: colorBg,
      leading: widget.leading,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline5?.copyWith(
            fontFamily: 'Pacifico',
            color: widget.colorTitle,
          ),
        ),
      ),
    );
  }
}