import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../constants/styles.dart';
import '../../states/auth_state.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
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
          const SizedBox(height: defaultPadding),
          StatefulBuilder(
            builder: (context, setter) => TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Mot de passe requis.";
                }
                return null;
              },
              obscureText: obscureText,
              controller: state.passwordController.value,
              decoration: InputDecoration(
                hintText: "Mot de passe",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.75),
                  child: SvgPicture.asset(
                    "assets/icons/Lock.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.3),
                        BlendMode.srcIn),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.75),
                  child: GestureDetector(
                    onTap: () {
                      setter(() => obscureText = !obscureText);
                    },
                    child: SvgPicture.asset(
                      obscureText == true
                          ? "assets/svgs/eye-alt.svg"
                          : "assets/svgs/eye-slash-alt.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
