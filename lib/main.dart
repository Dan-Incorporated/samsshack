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
import 'package:samsshack/models/user.dart';
import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/services/http_client.dart';
import 'package:samsshack/services/service_manager.dart';
import 'package:samsshack/services/shared_preferences.dart';
import 'package:samsshack/settings.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:samsshack/struc/error_handler.dart';
import 'package:samsshack/struc/routes.dart';
import 'package:samsshack/struc/store/store.dart';
import 'package:samsshack/struc/store/store_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:routemaster/routemaster.dart';

// ==============================================================================/
// MAIN =========================================================================/
// ==============================================================================/

Future<void> main() async {
  // config
  await dotenv.load(fileName: "assets/env/.env"); // load environment variables from .env
  setUriBase(); // set url based on env vars and state
  // Routemaster.setPathUrlStrategy(); // removes leading # from url, has some consequences with url routing

  // setup navigator
  final RoutemasterDelegate routemaster = RoutemasterDelegate(
    routesBuilder: (BuildContext context) => routeMap,
  );
  routemaster.setInitialRoutePath(RouteData(routeSplash));

  // setup store
  HttpClientBase httpClient = HttpClientBase(Client());
  Store store = Store(
    client: httpClient,
    user: User(),
    services: ServiceManager(client: httpClient),
  );

  // error handling
  ErrorHandler errorHandler = ErrorHandler();

  // start application
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized(); // helps with 'settling' widgets, needs to be in runZonedGuarded
    errorHandler.setFlutterError();
    runApp(StoreContainer(
        store: store,
        child: MyApp(
          routemaster: routemaster,
          errorHandler: errorHandler,
        )));
  }, (Object error, StackTrace stack) {
    errorHandler.sendErrorStackTrace(error, stack);
  });
}

/// ==============================================================================
/// MY APP =======================================================================
/// ==============================================================================

class MyApp extends StatefulWidget {
  final RoutemasterDelegate routemaster;
  final ErrorHandler errorHandler;

  const MyApp({Key? key, required this.routemaster, required this.errorHandler}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final ValueNotifier<bool> darkNotifier = ValueNotifier<bool>(false);

class _MyAppState extends BaseState<MyApp> {
  @override
  Widget build(BuildContext context) {
    setInitialDarkValue();
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return MaterialApp.router(
              title: "Sams Shack",
              routerDelegate: widget.routemaster,
              routeInformationParser: const RoutemasterParser(),
              debugShowCheckedModeBanner: false,
              checkerboardOffscreenLayers: false,
              //***** theme settings *****//
              theme: themeLight.copyWith(
                colorScheme: themeLight.colorScheme.copyWith(secondary: colorSecondary),
              ),
              darkTheme: themeDark.copyWith(
                colorScheme: themeLight.colorScheme.copyWith(secondary: colorSecondary),
              ),
              themeMode: !isDark ? ThemeMode.light : ThemeMode.dark,
              //***** error builder *****//
              builder: (BuildContext context, Widget? tmp) {
                widget.errorHandler.setErrorWidget(context);
                return tmp!;
              });
        });
  }

  Future<void> setInitialDarkValue() async {
    darkNotifier.value = await Preferences().prefGetDarkMode();
  }
}
