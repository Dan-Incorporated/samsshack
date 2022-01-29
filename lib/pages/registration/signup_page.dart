import 'package:flutter/material.dart';
import 'package:samsshack/struc/base_state.dart';
import 'package:samsshack/struc/routes.dart';
import 'package:samsshack/widgets/app_bar.dart';
import 'package:samsshack/widgets/buttons/base.dart';
import 'package:samsshack/widgets/cards/base.dart';
import 'package:samsshack/widgets/dialogs/toasts.dart';
import 'package:samsshack/widgets/forms/validation_manager.dart';
import 'package:samsshack/widgets/forms/validators.dart';
import 'package:routemaster/routemaster.dart';

// ================================================================================
// SIGNUP PAGE ====================================================================
// ================================================================================

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

// ================================================================================
// SIGNUP PAGE STATE ==============================================================
// ================================================================================

class _SignupPageState extends BaseState<SignupPage> {

  // form work
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormValidationManager _formValidationManager = FormValidationManager();

  // controllers
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordConfirmation = TextEditingController();

  @override
  void dispose() {
    _formValidationManager.dispose();
    super.dispose();
  }

  @override
  Widget buildBase(BuildContext context) {
    return Scaffold(
        appBar: const AppBarBase(),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CardBase(
              colorBorder: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: controllerEmail,
                          focusNode: _formValidationManager.getFocusNodeForField('email'),
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(labelText: 'Email'),
                          onFieldSubmitted: (_) => _formValidationManager.fieldFocusChange(
                            context,
                            _formValidationManager.getFocusNodeForField('email'),
                            _formValidationManager.getFocusNodeForField('password'),
                          ),
                          validator: _formValidationManager.wrapValidator(
                            'email',
                                (String? value) => value!.isEmpty
                                ? "Email required"
                                : value.isValidEmail()
                                ? null
                                : "Check email is valid",
                          )),
                      TextFormField(
                        controller: controllerPassword,
                        focusNode: _formValidationManager.getFocusNodeForField('password'),
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Password'),
                        onFieldSubmitted: (_) => _formValidationManager.fieldFocusChange(
                          context,
                          _formValidationManager.getFocusNodeForField('password'),
                          _formValidationManager.getFocusNodeForField('passwordConfirmation'),
                        ),
                        validator: _formValidationManager.wrapValidator(
                          'password',
                              (String? value) => value!.isNotEmpty ? null : "Password required",
                        ),
                      ),
                      TextFormField(
                        controller: controllerPasswordConfirmation,
                        focusNode: _formValidationManager.getFocusNodeForField('passwordConfirmation'),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Password Confirmation'),
                        onFieldSubmitted: (_) => pressedSubmit(),
                        validator: _formValidationManager.wrapValidator(
                          'passwordConfirmation',
                              (String? value) => value == controllerPassword.text ? null : "Make sure password confirmation matches",
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonBase(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: pressedSubmit,
                              text: "Submit",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Future<void> pressedSubmit() async {
    if (_formKey.currentState!.validate()) {
      loading = true;
      Map<String, dynamic> res =
      await BaseState.store.services.authApi.postSignupApi(email: controllerEmail.text, password: controllerPassword.text);
      loading = false;
      toastBase(context, message: res['message']);
      if (!res['error']) {
        Routemaster.of(context).replace(routeHome);
      }
    } else {
      toastBase(context, message: 'Please check you filled out all the fields');
    }
  }
}
