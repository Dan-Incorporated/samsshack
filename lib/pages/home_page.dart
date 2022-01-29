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
import 'package:samsshack/widgets/app_bar.dart';

// ================================================================================
// HOME PAGE ======================================================================
// ================================================================================

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// ================================================================================
// HOME PAGE STATE ================================================================
// ================================================================================

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget buildBase(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(leading: Container()),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Welcome to Sams Shack!',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            Text('Follow the output of your initialize script or your setup file to get started!', style: Theme.of(context).textTheme.headline6)
          ],
        ),
      ),
    );
  }
}
