/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';

/// ==========================================================================================/
/// LOADING INDICATOR ========================================================================/
/// ==========================================================================================/

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  _LoadingIndicatorIndicatorState createState() => _LoadingIndicatorIndicatorState();
}

/// ==========================================================================================/
/// LOADING INDICATOR STATE ==================================================================/
/// ==========================================================================================/

class _LoadingIndicatorIndicatorState extends State<LoadingIndicator> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController!,
        child: SizedBox(
          height: 150.0,
          width: 150.0,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        builder: (BuildContext context, Widget? _widget) {
          return Transform.rotate(
            angle: _animationController!.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}
