/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/pages/home_page.dart';
import 'package:samsshack/pages/registration/login_page.dart';
import 'package:samsshack/pages/registration/signup_page.dart';
import 'package:samsshack/pages/splash_page.dart';
import 'package:routemaster/routemaster.dart';

String absoluteRoute(String route) {
  if (route[0] == '/') {
    return route;
  } else {
    return "/$route";
  }
}

String relativeRoute(String route) {
  if (route[0] == '/') {
    return route.substring(1);
  } else {
    return route;
  }
}

/// ===============================================================================
/// ROUTES ========================================================================
/// ===============================================================================
///
/// These are your [routes] to link to different pages/widgets throughout
/// your application. These are connected via your [RouteMap].
///
/// Navigation 2.0 is implemented via the [Routemaster] package available here:
/// https://pub.dev/packages/routemaster
///
const String routeSplash = '/';
const String routeHome = '/home';
// REGISTRATION
const String routeLogin = '/login';
const String routeSignup = '/signup';

// ======================================
//
// ROUTE MAP
//
final RouteMap routeMap = RouteMap(routes: <String, RouteSettings Function(RouteData)>{
  routeSplash: (_) => const MaterialPage<SplashPage>(
        child: SplashPage(),
      ),
  routeHome: (_) => const MaterialPage<HomePage>(
        child: HomePage(),
      ),
  // REGISTRATION ================================
  routeLogin: (_) => const MaterialPage<LoginPage>(
        child: LoginPage(),
      ),
  routeSignup: (_) => const MaterialPage<SignupPage>(
        child: SignupPage(),
      ),
});
