import 'package:get/get.dart';
import 'package:royal_taxi_beta/route/screen_export.dart';
import 'package:royal_taxi_beta/screens/auth/states/auth_state.dart';

import '../../../../constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpForm extends StatelessWidget {
  final bool isLoggedIn;
  const OtpForm({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _pinInput(context, isLoggedIn),
      ],
    ));
  }

  Widget _pinInput(BuildContext context, bool isLoggedIn) {
    final focusNode = FocusNode();
    final state = Get.put(AuthState());

    // Obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;

    // Ajuster la largeur et la hauteur en fonction de la taille de l'écran
    final pinWidth = screenWidth * 0.12;

    final defaultPinTheme = PinTheme(
      width: pinWidth,
      height: 55.0,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Valeur ajustée
        color: Colors.white,
        border: Border.all(
          color: greyColor80,
        ),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        focusNode: focusNode,
        length: 6,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        useNativeKeyboard: true,
        separatorBuilder: (index) => SizedBox(width: screenWidth * .05),
        validator: (value) {
          return value == "123456" ? null : 'Veuillez entrer un otp valide!';
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          state.verifyOtp(pin, onSuccess: () {
            if (isLoggedIn) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeScreenRoute, (route) => false);
            } else {
              Navigator.pushNamed(context, signUpScreenRoute);
            }
          });
        },
        onChanged: (value) {
          debugPrint('onChanged: ');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: const Color.fromARGB(255, 238, 114, 114)),
          ),
        ),
      ),
    );
  }
}
