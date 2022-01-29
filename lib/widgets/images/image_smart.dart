/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// ===================================================================================/
/// IMAGE SMART =======================================================================/
/// ===================================================================================/
///
/// Customizable image widget to help handling a few situations
/// - dynamically swap between local asset images and network images
/// - handle null and empty image fields
/// - easy formatting/styling
///
/// @[PARAM]
/// - String source           - input location/source string for image, this can be
///                             a local file, network image, null or empty
/// - double borderRadius     - (Optional) border radius to apply to image
///
class ImageSmart extends StatefulWidget {
  final String source;
  final double borderRadius;

  const ImageSmart({Key? key, required this.source, this.borderRadius = 8.0}) : super(key: key);

  @override
  _ImageSmartState createState() => _ImageSmartState();
}

class _ImageSmartState extends State<ImageSmart> {
  @override
  Widget build(BuildContext context) {
    if (widget.source == "") {
      return Container();
    }
    bool isNetwork = false;
    if (widget.source.contains('http')) {
      isNetwork = true;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: isNetwork
          ? Image.network(
              widget.source,
              fit: BoxFit.cover,
            )
          : Image.asset(widget.source, fit: BoxFit.cover),
    );
  }
}
