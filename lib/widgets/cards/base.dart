/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';

/// ===================================================================================/
/// CARD BASE =========================================================================/
/// ===================================================================================/

class CardBase extends StatelessWidget {
  final double elevation;
  final double radius;
  final Color colorBorder;
  final double borderWidth;
  final Color? color;
  final Function()? onTap;
  final Widget? child;

  const CardBase({
    Key? key,
    this.elevation = 4.0,
    this.radius = 8.0,
    this.colorBorder = Colors.transparent,
    this.borderWidth = 2.0,
    this.color,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: color,
      child: Card(
        color: color,
        elevation: elevation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: child,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorBorder, width: borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
