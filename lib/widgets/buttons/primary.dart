/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/widgets/buttons/base.dart';

/// =========================================================================/
/// BUTTONS =================================================================/
/// =========================================================================/

class ButtonPrimary extends StatelessWidget {
  final Function onPressed;
  final String text;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool alternate;
  final bool enabled;
  final double elevation;
  final IconData? icon;
  final TextStyle? textStyle;

  const ButtonPrimary({
    Key? key,
    required this.onPressed,
    this.text = "",
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.alternate = false,
    this.enabled = true,
    this.elevation = 8.0,
    this.icon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      text: text,
      icon: icon,
      onPressed: onPressed,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      style: textStyle,
      enabled: enabled,
      elevation: elevation,
      colorBorder: !alternate ? Colors.transparent : Theme.of(context).primaryColor,
      color: !alternate ? Theme.of(context).primaryColor : Colors.white,
      colorIcon: !alternate ? Colors.white : Theme.of(context).primaryColor,
      colorText: !alternate ? Colors.white : Theme.of(context).primaryColor,
    );
  }
}
