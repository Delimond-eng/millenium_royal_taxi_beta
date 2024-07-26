import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/screens/auth/states/auth_state.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../../../constants/styles.dart';
import '../../../route/route_constants.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var state = Get.put(AuthState());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/taxi-app-2.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                      "Veuillez entrer le code. Un code à 6 chiffres a été envoyé au ${state.phoneController.value.text}"),
                  const SizedBox(height: defaultPadding),
                  Obx(() {
                    return Center(
                        child: OtpForm(
                      isLoggedIn: state.isLoggedIn.value,
                    ));
                  }),
                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),
                  Obx(
                    () => state.isLoadingState.value
                        ? const Center(
                            child: SpinKitFadingCircle(
                              color: blackColor,
                              size: 40.0,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Code non reussi."),
                      TextButton(
                        onPressed: () {
                          state.verifyPhoneNumber((vId) {});
                        },
                        child: const Text("Renvoyer le code"),
                      )
                    ],
                  ).paddingHorizontal(20.0),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: .8,
                    dashLength: 10,
                    dashColor: Colors.grey.shade500,
                  ).paddingVertical(10.0),
                  if (!state.isLoggedIn.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Avez-vous un compte ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, logInScreenRoute);
                          },
                          child: const Text("Connectez-vous"),
                        )
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
