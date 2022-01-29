/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';

/// =========================================================================
/// BUTTON BASE =============================================================
/// =========================================================================

class ButtonBase extends StatelessWidget {
  final String text;
  final Function onPressed;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool enabled;
  final double elevation;
  final Color colorBorder;
  final Color color;
  final Color colorIcon;
  final Color colorText;
  final IconData? icon;
  final TextStyle? style;

  const ButtonBase({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.style,
    this.enabled = true,
    this.elevation = 0.0,
    this.colorBorder = Colors.transparent,
    this.color = Colors.black54,
    this.colorIcon = Colors.white,
    this.colorText = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(
            elevation,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder(
            side: BorderSide(
              color: enabled ? colorBorder : Colors.transparent,
              width: 2.0,
            ),
          ))),
      child: Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: style ??
                  Theme.of(context).textTheme.headline6?.copyWith(
                    color: colorText,
                  ),
            ),
          ),
          icon != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: colorIcon,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
