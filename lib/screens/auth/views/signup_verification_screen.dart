import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../states/auth_state.dart';
import '/screens/auth/views/components/signup_verification_form.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../route/screen_export.dart';

class SignupVerificationScreen extends StatefulWidget {
  const SignupVerificationScreen({super.key});

  @override
  State<SignupVerificationScreen> createState() =>
      _SignupVerificationScreenState();
}

class _SignupVerificationScreenState extends State<SignupVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthState _authState;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authState = Get.put(AuthState());
  }

  @override
  Widget build(BuildContext context) {
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
                    "Inscription",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Veuillez entrer votre numéro de téléphone valide.",
                  ),
                  const SizedBox(height: defaultPadding),
                  SignUpVerificationForm(formKey: _formKey),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            setState(() {
                              isLoading = true;
                            });
                            _authState.verifyPhoneNumber((verifyId) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushNamed(context, otpScreenRoute);
                            });
                          },
                    child: isLoading
                        ? const SpinKitThreeBounce(
                            size: 15.0,
                            color: blackColor,
                          )
                        : const Text("Continuer"),
                  ),
                  const SizedBox(height: defaultPadding),
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
