/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/settings.dart';
import 'package:samsshack/struc/store/store.dart';
import 'package:samsshack/struc/store/store_container.dart';
import 'package:samsshack/widgets/loading_indicator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ================================================================================/
// BASE STATE =====================================================================/
// ================================================================================/

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final double widthContent = 800.0; // max width for content itself

  // store
  static late Store store;
  bool initial = true;

  // connectivity
  static bool _connectionOnline = false;
  static ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  // LOADING ===================== /
  bool loadingState = false;

  set loading(bool status) {
    setState(() {
      loadingState = status;
    });
  }

  bool get loading {
    return loadingState;
  }

  // END LOADING ================ /

  ///***** INIT *****///
  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  ///***** BUILD *****///
  @override
  Widget build(BuildContext context) {
//    debugPrint("BaseState(${T.toString()}).build executed");
    BaseState.store = StoreContainer.of(context).widget.store;
    return FutureBuilder<bool>(
        future: loadWidget(context, initial),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          // LOADING = return loading
          if (loading) {
            return Scaffold(
              body: Container(
                color: Theme.of(context).primaryColor,
                child: const Center(
                  child: LoadingIndicator(),
                ),
              ),
            );
          }
          // VALID - build widget
          else if (snapshot.hasData) {
            if (snapshot.data!) {
              initial = false;
              return buildBase(context);
            } else {
              throw ("base_state.dart -- snapshot does not have data");
            }
          }
          // CONNECTION INVALID
          else if (!_connectionOnline) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Text("Unable to connect to the internet. Please try again.", style: Theme.of(context).textTheme.headline4,),
                ),
              ),
            );
          }
          // STATE UNKNOWN
          else {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: const Center(
                  child: LoadingIndicator(),
                ),
              ),
            );
          }
        });
  }

  ///***** BUILD BASE *****///
  ///
  /// ** IMPORTANT **
  ///
  /// Inherited class should create widget here instead of from the build method,
  /// this only works with Page (Scaffold) level widgets due to the nature of the
  /// above FutureBuilder. Because of this, you cannot do 'widget level' loading
  /// through this mechanism.
  ///
  @protected
  Widget buildBase(BuildContext context) {
    return Container();
  }

  ///***** LOAD WIDGET *****///
  ///
  /// The following procedure is used for widget startup loading, remember to
  /// use await when calling any async call.
  ///
  @protected
  Future<bool> loadWidget(BuildContext context, bool isInit) async {
    return true;
  }

  // ===================================================================================/
  // ===================================================================================/
  // ===================================================================================/

  // CONNECTION ================ /
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logPrint("initConnectivity: ${e.toString()}", tag: "EXP");
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future<void>.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionOnline = true;
        break;
      case ConnectivityResult.mobile:
        _connectionOnline = true;
        break;
      case ConnectivityResult.ethernet:
        _connectionOnline = true;
        break;
      case ConnectivityResult.none:
        _connectionOnline = false;
        break;
      default:
        _connectionOnline = true;
        break;
    }
    setState(() {
      _connectionStatus = result;
    });
  }
  // END CONNECTION ============== /

}
