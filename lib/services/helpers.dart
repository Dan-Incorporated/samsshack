/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samsshack/settings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

/// ============================================================================/
/// LOGGING ====================================================================/
/// ============================================================================/
///
/// Default logging function. Will not print in production and offers some nice
/// formatting to make more noticeable.
///
logPrint(
    String msg, {
      String tag = "INFO",
      String sym = "*",
    }) {
  debugPrint("========================================");
  debugPrint("[ $sym $tag $sym ]\n$msg");
  debugPrint("========================================");
}

/// ============================================================================/
/// PLATFORM / CONFIG DETECTION ================================================/
/// ============================================================================/
///
/// Functions to help detect different configurations, platforms, settings,
/// etc. These should be standardized and used throughout the app to help
/// detect different states.
///
bool isTestMode() {
  return dotenv.get('ENVIRONMENT') == ENV_OPTIONS.test.toString();
}

bool isDevMode() {
  return dotenv.get('ENVIRONMENT') == ENV_OPTIONS.dev.toString();
}

bool isProdMode() {
  // TODO what to do with this?
  // return dotenv.get('ENVIRONMENT') == ENV_OPTIONS.prod.toString();
  if (kReleaseMode) {  // detects if truly in production or not
    return true;
  } else {
    return false;
  }
}

bool isWeb() {
  return kIsWeb;
}


/// ============================================================================/
/// SCREEN MEASURING ===========================================================/
/// ============================================================================/

double measureScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double measureScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// ============================================================================/
/// URI LAUNCHER ===============================================================/
/// ============================================================================/

void uriOpen(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}


/// ============================================================================/
/// URI BASE ===================================================================/
/// ============================================================================/

String uriBase = dotenv.get('URI_BASE');

// set uri based on any particular circumstances/config
// this function SHOULD be called close to app start up
// to ensure the uri is as up to date as possible
void setUriBase() {
  if (!isProdMode() && !isWeb()) {
    // ONLY allow if NOT production
    if ((uriBase.contains('localhost') || uriBase.contains('127.0.0.1')) && Platform.isAndroid) {
      uriBase = "http://10.0.2.2:8000"; // android specific bug
    }
  }
}

// base uri for api requests
String uriBaseApi() {
  return uriBase + "/api";
}
