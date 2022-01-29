/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:routemaster/routemaster.dart';

/// =================================================================================
/// TEXT LINK =======================================================================
/// =================================================================================
///
/// [NOTES]
/// - Case sensitive
/// - Will highlight ONLY first occurrence of textToHighlight
/// - [route] will replace the current page while [url] will open in a new tab
///
class TextLink extends StatefulWidget {
  final String text;
  final String? url;
  final String? route;
  final String? textToHighlight;
  final TextStyle? style;

  TextLink({Key? key, required this.text, this.url, this.route, this.textToHighlight, this.style}) : super(key: key) {
    assert(
      (url != null || route != null),
      'Must provide either URL or Route.',
    );
  }

  @override
  _TextLinkState createState() => _TextLinkState();
}

class _TextLinkState extends BaseState<TextLink> {
  List<String> matchArray = <String>[];
  bool matchFound = false;
  late TextStyle styleHighlight;
  late TextStyle styleText;

  @override
  void initState() {
    // find if text matching exists
    if (widget.textToHighlight != null) {
      List<String> tmp = widget.text.toLowerCase().split(widget.textToHighlight!.toLowerCase()); // check against lowercase string
      if (tmp.length != 1) {
        // match(es) found
        matchFound = true;
        List<String> res = widget.text.split(widget.textToHighlight!);
        matchArray = res;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   // set style for highlight and text based on input
    TextStyle styleDefault = DefaultTextStyle.of(context).style;
    if (widget.style == null) {
      styleHighlight = styleDefault.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold);
      styleText = styleDefault;
    } else {
      // style given
      styleHighlight = widget.style!.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold);
      styleText = widget.style!;
    }

    return InkWell(
      onTap: () async {
        if (widget.url != null) {
          uriOpen(widget.url!);
        } else {
          // if URL is null, route CANNOT be null (check constructor)
          Routemaster.of(context).push(widget.route!);
        }
      },
      child: RichText(
        text: TextSpan(
          children: matchFound
              ? <TextSpan>[
                  TextSpan(text: matchArray[0], style: styleText),
                  TextSpan(text: widget.textToHighlight, style: styleHighlight),
                  TextSpan(text: matchArray[1], style: styleText),
                ]
              : <TextSpan>[
                  TextSpan(
                    text: widget.text,
                    style: styleHighlight,
                  )
                ],
        ),
      ),
    );
  }
}
