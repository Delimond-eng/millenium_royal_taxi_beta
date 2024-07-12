// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpVerificationForm extends StatelessWidget {
  const SignUpVerificationForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return Form(
      key: formKey,
      child: Column(
        children: [
          IntlPhoneField(
            focusNode: focusNode,
            searchText: "Recherche pays.",
            decoration: const InputDecoration(
              hintText: "Numéro de téléphone",
              counterText: '',
            ),
            validator: (value) {
              if (value == null || value.number.isEmpty) {
                return 'Numéro de téléphone requis.';
              }
              final isValid = value.number.length > 9;
              if (isValid) {
                return 'Le numéro de téléphone doit comporter au moins 9 chiffres.';
              }
              return null;
            },
            languageCode: "fr",
            initialCountryCode: "CD",
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            onCountryChanged: (country) {
              print('Country changed to: ' + country.name);
            },
          ),
        ],
      ),
    );
  }
}
