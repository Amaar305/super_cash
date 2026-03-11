import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:flutter/foundation.dart' show immutable;
import 'package:form_fields/src/formz_validation_mixin.dart';
import 'package:formz/formz.dart';

/// {@template EmailOrPhone}
/// Formz input for EmailOrPhone. It can be empty or invalid.
/// {@endtemplate}
@immutable
class EmailOrPhone extends FormzInput<String, EmailOrPhoneValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro EmailOrPhone.pure}
  const EmailOrPhone.pure([super.value = '']) : super.pure();

  /// {@macro EmailOrPhone.dirty}
  const EmailOrPhone.dirty(super.value) : super.dirty();
  static final _emailRegex = RegExp(
    r'^(([\w-]+\.)+[\w-]+|([a-zA-Z]|[\w-]{2,}))@((([0-1]?'
    r'[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.'
    r'([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
    r')|([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$',
  );

  static final _phoneRegex = RegExp(r'^0\d{10}$');

  @override
  EmailOrPhoneValidationError? validator(String value) {
    if (value.isEmpty) return EmailOrPhoneValidationError.empty;
    if (!_emailRegex.hasMatch(value) && !_phoneRegex.hasMatch(value)) {
      return EmailOrPhoneValidationError.invalid;
    }
    return null;
  }

  /// EmailOrPhone validation errors message
  @override
  Map<EmailOrPhoneValidationError?, String?> get validationErrorMessage => {
        EmailOrPhoneValidationError.empty: 'This field is required',
        EmailOrPhoneValidationError.invalid:
            'Email or phone number is not correct',
        null: null,
      };

  @override
  List<Object> get props => [pure, value];
}

/// Validation errors for [EmailOrPhone]. It can be empty, invalid or already
/// registered.
enum EmailOrPhoneValidationError {
  /// Empty EmailOrPhone.
  empty,

  /// Invalid EmailOrPhone.
  invalid,
}
