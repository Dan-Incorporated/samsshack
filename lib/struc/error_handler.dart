import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:samsshack/widgets/texts/base.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// ==========================================================================================
/// ERROR HANDLER ============================================================================
/// ==========================================================================================
///
/// Flutter error handler, handles FlutterError and WidgetError
/// as well as emailing the Django backend with bug reports
///
/// More about error handling https://docs.flutter.dev/testing/errors#define-a-custom-error-widget-for-build-phase-errors
///
class ErrorHandler {
  bool sentEmail = false;

  /// ================================
  ///
  /// setFlutterError
  ///
  void setFlutterError() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      sendErrorDetails(details);
    };
  }

  /// ================================
  ///
  /// setErrorWidget
  ///
  void setErrorWidget(
      BuildContext context,
      ) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      sendErrorDetails(details);
      return widgetError(context);
    };
  }

  /// ================================
  ///
  /// widgetError
  ///
  Widget widgetError(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextBase(
                    "Uh Oh :/",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "It seems you've found a bug, please restart the application or try again later.",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================================
  ///
  /// sendErrorDetails
  ///
  void sendErrorDetails(FlutterErrorDetails details) async {
    if (sentEmail == false && isProdMode() == true) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String os = "Web";
      if (!isWeb()) {
        os = Platform.isIOS ? "iOS" : "Android";
      }
      DateTime now = DateTime.now();
      String time = DateFormat('MM/dd/yyyy @ kk:mm a').format(now);

      // send message
      BaseState.store.services.emailApi.postEmail(subject: '[Flutter] Crash Report - Sams Shack', message: """Error in Sams Shack application
      
VERSION: ${packageInfo.version}
TIME: $time
OS: $os
--------------------------------------
${details.exception.toString()}
--------------------------------------
${details.stack.toString()}""");
      logPrint("Message sent!", tag: "SUCCESS");
    }
  }

  /// ================================
  ///
  /// sendErrorStackTrace
  ///
  void sendErrorStackTrace(Object error, StackTrace stack) async {
    if (sentEmail == false && isProdMode() == true) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String os = "Web";
      if (!isWeb()) {
        os = Platform.isIOS ? "iOS" : "Android";
      }
      DateTime now = DateTime.now();
      String time = DateFormat('MM/dd/yyyy @ kk:mm a').format(now);

      // send message
      BaseState.store.services.emailApi.postEmail(subject: '[Flutter] Crash Report - Sams Shack', message: """Error in Sams Shack application
      
VERSION: ${packageInfo.version}
TIME: $time
OS: $os
--------------------------------------
${error.toString()}
--------------------------------------
${stack.toString()}""");
      logPrint("Message sent!", tag: "SUCCESS");
    }
  }
}
