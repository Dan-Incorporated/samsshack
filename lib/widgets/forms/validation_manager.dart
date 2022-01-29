/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */
import 'package:flutter/material.dart';

/// ================================================================================
/// VALIDATION MANAGER =============================================================
/// ================================================================================
///
/// Class to manage forms - get errors, consolidate validation, etc.
/// ** USAGE **
/// To use the ValidationManager you must first declare it as a field in your widget:
///    final _formValidationManager = FormValidationManager();
///
/// Then you must include it, and use its validators, in your FormField widgets:
///
///           TextFormField(
///             controller: controllerName,
///             focusNode: _formValidationManager.getFocusNodeForField('name'),
///             textInputAction: TextInputAction.next,
///             onFieldSubmitted: (_) => _formValidationManager.fieldFocusChange(
///               context,
///               _formValidationManager.getFocusNodeForField('name'),
///               _formValidationManager.getFocusNodeForField('email'),
///             ),
///             validator: _formValidationManager.wrapValidator(
///               'name',
///               (value) => value!.isNotEmpty ? null : "Name required",
///             ),
///           ),
///
/// **
/// ** IMPORTANT: must be DISPOSED at end of widget life cycle **
/// **
///
class FormValidationManager {
  final Map<String, FormFieldValidationState> _fieldStates = <String, FormFieldValidationState>{};

  FocusNode getFocusNodeForField(String key) {
    _ensureExists(key);

    return _fieldStates[key]!.focusNode;
  }

  fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  FormFieldValidator<T> wrapValidator<T>(String key, FormFieldValidator<T> validator) {
    _ensureExists(key);

    return (T? input) {
      final String? result = validator(input);

      _fieldStates[key]!.hasError = (result?.isNotEmpty ?? false);

      return result;
    };
  }

  List<FormFieldValidationState> get errorFields => _fieldStates.entries
      .where((MapEntry<String, FormFieldValidationState> s) => s.value.hasError)
      .map((MapEntry<String, FormFieldValidationState> s) => s.value)
      .toList();

  void _ensureExists(String key) {
    _fieldStates[key] ??= FormFieldValidationState(key: key);
  }

  void dispose() {
    for (MapEntry<String, FormFieldValidationState> s in _fieldStates.entries) {
      s.value.focusNode.dispose();
    }
  }
}

class FormFieldValidationState {
  final String key;

  bool hasError;
  FocusNode focusNode;

  FormFieldValidationState({required this.key})
      : hasError = false,
        focusNode = FocusNode();
}
