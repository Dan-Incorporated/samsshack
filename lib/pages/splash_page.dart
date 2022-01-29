/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:samsshack/struc/routes.dart';
import 'package:samsshack/widgets/loading_indicator.dart';
import 'package:routemaster/routemaster.dart';

// ====================================================================================
// SPLASH PAGE ========================================================================
// ====================================================================================

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

/// ================================================================================
/// SPLASH PAGE STATE ==============================================================
/// ================================================================================

class _SplashPageState extends BaseState<SplashPage> {
  late Timer timer;

  //***** INIT *****//
  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), () {
      if (Routemaster.of(context).currentRoute.path == routeSplash) {
        // only navigate if current route is splash
        Routemaster.of(context).push(routeHome);
      }
    });
    super.initState();
  }

  //***** DISPOSE *****//
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //***** BUILD *****//
  @override
  Widget buildBase(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
    return Container(color: Theme.of(context).primaryColor, child: const LoadingIndicator());
  }
}
