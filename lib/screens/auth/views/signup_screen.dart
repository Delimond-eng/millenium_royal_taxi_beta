import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/screens/auth/states/auth_state.dart';
import '/screens/auth/views/components/sign_up_form.dart';
import '/route/route_constants.dart';

import '../../../constants/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool allowed = false;
  bool isLoading = false;
  late AuthState _authState;

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
                    "Veuillez entrer vos données valides afin de créer un compte.",
                  ),
                  const SizedBox(height: defaultPadding),
                  SignUpForm(formKey: _formKey),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Theme.of(context).primaryColorLight,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            allowed = value!;
                          });
                        },
                        value: allowed,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "J'accepte les",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, termsOfServicesScreenRoute);
                                  },
                                text: " conditions d'utilisation ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& la politique de confidentialité.",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  ElevatedButton(
                    onPressed: !allowed || isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              _authState.registerUser(onSuccess: () {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushNamedAndRemoveUntil(
                                    context, homeScreenRoute, (route) => false);
                              });
                            }
                          },
                    child: isLoading
                        ? const SpinKitThreeBounce(
                            size: 15.0,
                            color: blackColor,
                          )
                        : const Text("Sauvegarder & Continuer"),
                  ),
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
