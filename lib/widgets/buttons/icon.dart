/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';

/// =========================================================================/
/// BUTTONS =================================================================/
/// =========================================================================/

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final bool enabled;
  final bool alternate;
  final double elevation;
  final String? caption;

  const ButtonIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.enabled = true,
    this.alternate = false,
    this.elevation = 8.0,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Material(
                elevation: elevation,
                child: IconButton(icon: Icon(icon), onPressed: enabled ? onPressed() : null, color: Colors.white),
                color: alternate ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: alternate ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        caption != null
            ? Text(
                caption!,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: alternate ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                    ),
              )
            : Container(),
      ],
    );
  }
}
