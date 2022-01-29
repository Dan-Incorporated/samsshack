/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:samsshack/services/rest-apis/auth/auth_api.dart';
import 'package:samsshack/services/rest-apis/email/email_api.dart';
import 'package:http/http.dart';

/// ==================================================================================/
/// SERVICE MANAGER ==================================================================/
/// ==================================================================================/
///
/// This class stores all the services that may be used by this application.
/// An (the) instance of this class will be held in the store to ensure
/// service/API data is easily accessible throughout the application.
///
class ServiceManager {
  Client client;

  // APIS
  // TODO - declare the APIs here that you intend to be accessible from the store
  late AuthApi authApi;
  late EmailApi emailApi;

  ServiceManager({
    required this.client,
  }) {
    authApi = AuthApi(client: client);
    emailApi = EmailApi(client: client);
  }
}
