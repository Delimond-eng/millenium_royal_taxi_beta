// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:royal_taxi_beta/screens/auth/states/auth_state.dart';

class SignUpVerificationForm extends StatelessWidget {
  const SignUpVerificationForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    var state = Get.put(AuthState());
    return Form(
      key: formKey,
      child: Column(
        children: [
          IntlPhoneField(
            focusNode: focusNode,
            searchText: "Recherche pays.",
            keyboardType: TextInputType.phone,
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
              state.phoneController.value.text = phone.completeNumber;
            },
            onCountryChanged: (country) {
              if (kDebugMode) {
                print('Country changed to: ' + country.name);
              }
            },
          ),
        ],
      ),
    );
  }
}
