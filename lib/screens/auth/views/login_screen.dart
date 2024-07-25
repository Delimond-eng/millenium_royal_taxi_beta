import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/screens/auth/states/auth_state.dart';
import '../../../constants/styles.dart';
import '/route/route_constants.dart';

import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: unused_field
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
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenue !",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Connectez-vous avec les données que vous avez saisies lors de votre inscription.",
                  ),
                  const SizedBox(height: defaultPadding),
                  LogInForm(formKey: _formKey),
                  Align(
                    child: TextButton(
                      child: const Text("Mot de passe oublié ?"),
                      onPressed: () async {},
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await _authState.signInWithPhoneAndPassword(
                                  onSuccess: () {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushNamedAndRemoveUntil(
                                    context, homeScreenRoute, (route) => false);
                              }, onFailed: () {
                                setState(() {
                                  isLoading = false;
                                });
                                EasyLoading.showToast(
                                  "Mot de passe ou numéro de téléphone invalide !",
                                  toastPosition:
                                      EasyLoadingToastPosition.bottom,
                                );
                              });
                            }
                          },
                    child: isLoading
                        ? const SpinKitThreeBounce(
                            size: 15.0,
                            color: blackColor,
                          )
                        : const Text("Connecter"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas de compte ?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, signUpVerificationScreenRoute);
                        },
                        child: const Text("S'inscrire"),
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
