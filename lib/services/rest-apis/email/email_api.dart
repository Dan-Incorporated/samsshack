/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'dart:convert';

import 'package:samsshack/services/helpers.dart';
import 'package:samsshack/services/rest-apis/api_helpers.dart';
import 'package:http/http.dart' as http;

/// ===============================================================================
/// EMAIL API =====================================================================
/// ===============================================================================
///
/// Basic email service to interact with Django bootstrapper Email API - effectively
/// an email sending API endpoint. It is authenticated via the domain of the request
/// so no token auth needed.
///
class EmailApi {
  // input
  http.Client client;
  Uri uriApiBase = Uri.parse("${uriBaseApi()}/email/"); // NOTE: this almost definitely should end in a '/'

  EmailApi({
    required this.client,
  });

  Future<Map<String, dynamic>> postEmail({required String message, String? subject}) async {
    // build request
    Map<String, String> headers = headerNoAuth();
    String body = bodyGeneric(map: <String, String>{"message": message});

    // send HTTP request to endpoint
    http.Response response;
    try {
      response = await client.post(uriApiBase, headers: headers, body: body);
    } catch (e) {
      logPrint("EmailService.postEmail: HTTP error\n${e.toString()}", tag: "EXP");
      return defaultErrorMap();
    }

    // process response
    Map<String, dynamic> decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // 200 -> valid
      return defaultSuccessMap(message: decoded['success']);
    } else if (response.statusCode == 401) {
      // 401 -> unauthorized
      return defaultErrorMap(message: decoded['detail']);
    } else {
      // 400, 500 and others -> error
      return defaultErrorMap(message: decoded['error']);
    }
  }
}
