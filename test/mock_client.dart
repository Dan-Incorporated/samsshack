import 'dart:convert';
import 'dart:io';

import 'package:samsshack/services/rest-apis/api_helpers.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

// function to get test resource file/json and return as string
String getTestResource(String path) {
  String dir = Directory.current.path;
  return File('$dir/test/test_resources/$path').readAsStringSync();
}

/// ==========================================================================================================/
/// MOCK CLIENT ==============================================================================================/
/// ==========================================================================================================/
///
/// Mock client is used to simulate network requests and their responses.
/// Well designed tests CANNOT rely on actual network/API usage and so
/// we use this mockClient instance to avoid that.
/// This is only really used for integration widget tests since we have
/// any number of arbitrary network calls going on at a given time.
///
MockClient mockClient = MockClient((Request request) async {
  String url = request.url.toString().toLowerCase();
  switch (url) {
    //
    // DEFAULT ============================================/
    //
    default:
      final Map<String, dynamic> jsonMap = defaultErrorMap();
      return Response(json.encode(jsonMap), 400);
  }
});
