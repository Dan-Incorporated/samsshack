/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:samsshack/struc/store/store.dart';

/// ========================================================================================
/// STORE CONTAINER ========================================================================
/// ========================================================================================

class StoreContainer extends StatefulWidget {
  // The store is managed by the container
  final Store store;

  // This widget is simply the root of the tree,
  // so it has to have a child!
  final Widget child;

  const StoreContainer({
    Key? key,
    required this.child,
    required this.store,
  }) : super(key: key);

  // This creates a method on the AppState that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppState all over your app
  static _StoreContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())!.data;
  }

  @override
  _StoreContainerState createState() => _StoreContainerState();
}

/// ========================================================================================
/// STORE CONTAINER STATE ==================================================================
/// ========================================================================================

class _StoreContainerState extends BaseState<StoreContainer> {
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  // So the WidgetTree is actually
  // AppStateContainer --> InheritedStateContainer --> The rest of your app.
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: _InheritedStateContainer(
        data: this,
        child: widget.child,
      ),
    );
  }
}

/// ========================================================================================
/// STORE CONTAINER ========================================================================
/// ========================================================================================

// This is likely all your InheritedWidget will ever need.
class _InheritedStateContainer extends InheritedWidget {
  // The data is whatever this widget is passing down.
  final _StoreContainerState data;

  // InheritedWidgets are always just wrappers.
  // So there has to be a child,
  // Although Flutter just knows to build the Widget that's passed to it
  // So you don't have have a build method or anything.
  const _InheritedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  // This is a better way to do this
  // Basically, Flutter automatically calls this method when any data
  // in this widget is changed.
  // You can use this method to make sure that flutter actually should
  // repaint the tree, or do nothing.
  // It helps with performance.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
