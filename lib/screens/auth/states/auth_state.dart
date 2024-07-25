import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/storage.dart';

import '/models/user.dart';

enum PhoneAuthState { initial, success, loading, codeSent, error }

class AuthState extends GetxController {
  static AuthState instance = Get.find();

  PhoneAuthState _phoneAuthState = PhoneAuthState.initial;

  var verificationId = ''.obs;

  var phoneController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var referralCodeController = TextEditingController().obs;
  var otpController = TextEditingController().obs;
  var fullNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var licensePlateController = TextEditingController().obs;
  var vehicleColorController = TextEditingController().obs;
  var vehicleTypeController = TextEditingController().obs;
  var vehicleManufacturersController = TextEditingController().obs;
  var role = Roles.passenger.obs;

  var controller = PageController().obs;
  var pageIndex = 0.obs;
  var uid = ''.obs;

  var timeOut = 30.obs;

  bool get isRoleDriver => role.value == Roles.driver;

  var otpVerifyId = "".obs;
  var otpfailed = "".obs;
  var isLoadingState = false.obs;

  var currentUser = Rx<auth.User?>(null);

  @override
  void onInit() {
    super.onInit();
    pageIndex.value = 0;
    uid.value = '';
    controller.value = PageController(initialPage: 0);
    //siginCurrentUser();
  }

  PhoneAuthState get phoneAuthState => _phoneAuthState;

  set changeRoleState(int value) {
    role = Roles.values[value] as Rx<Roles>;
  }

  set phoneAuthStateChange(PhoneAuthState phoneAuthState) {
    _phoneAuthState = phoneAuthState;
  }

  //Verify phoneNumber
  Future<void> verifyPhoneNumber(Function(String otpVerifyId) codeSent) async {
    isLoadingState.value = false;
    auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.value.text,
      verificationCompleted: (auth.PhoneAuthCredential credential) async {
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (auth.FirebaseAuthException e) {
        otpVerifyId.value = "";
        _phoneAuthState = PhoneAuthState.error;
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVerifyId.value = verificationId;
        _phoneAuthState = PhoneAuthState.codeSent;
        codeSent.call(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _startCountDown();
      },
    );
  }

  //Method allow to verify otp
  Future<void> verifyOtp(String smsCode, {VoidCallback? onSuccess}) async {
    try {
      isLoadingState.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otpVerifyId.value,
        smsCode: smsCode,
      );
      await auth.FirebaseAuth.instance.signInWithCredential(credential);
      currentUser.value = auth.FirebaseAuth.instance.currentUser;
      isLoadingState.value = false;
      onSuccess!.call();
    } catch (e) {
      otpfailed.value = "failed";
      isLoadingState.value = false;
    }
  }

  void _startCountDown() {
    if (_phoneAuthState == PhoneAuthState.codeSent) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick > 30) {
          timer.cancel();
        } else {
          --timeOut;
        }
      });
    }
  }

  //Login user with phoneNumber and password
  //@return dynamic boolean OR Null
  Future<dynamic> signInWithPhoneAndPassword(
      {VoidCallback? onSuccess, VoidCallback? onFailed}) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneController.value.text)
          .where('password', isEqualTo: passwordController.value.text)
          .get();
      print(userQuery.docs.first);

      if (userQuery.docs.isNotEmpty) {
        // L'utilisateur existe et le mot de passe est correct
        await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userQuery.docs[0]['email'],
          password: passwordController.value.text,
        );
        currentUser.value = auth.FirebaseAuth.instance.currentUser;
        storage.write("refreshToken", currentUser.value!.refreshToken);
        onSuccess!.call();
      } else {
        onFailed!.call();
        return null;
      }
    } catch (e) {
      print(e);
      onFailed!.call();
      return null;
    }
  }

  Stream<auth.User?> get streamUser {
    return auth.FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signCurrentUser() async {
    var refreshToken = storage.read("refreshToken");
    if (refreshToken != null) {
      try {
        await auth.FirebaseAuth.instance.signInWithCustomToken(refreshToken);
        currentUser.value = auth.FirebaseAuth.instance.currentUser;
      } catch (e) {
        print("Error signing in with refresh token: $e");
      }
    }
  }

  Future<void> logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  //Register user
  Future<dynamic> registerUser({VoidCallback? onSuccess}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      // Créez un utilisateur anonyme pour obtenir un UID
      var user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No current user after phone verification');
        return;
      }
      // Mettez à jour l'adresse e-mail et le mot de passe
      await user.verifyBeforeUpdateEmail(emailController.value.text);
      await user.updatePassword(passwordController.value.text);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullname': fullNameController.value.text,
        'email': emailController.value.text,
        'phoneNumber': phoneController.value.text,
        'referralCode': referralCodeController.value.text,
        'password': passwordController.value.text,
        'is_active': true,
        'latlng': {'lat': position.latitude, 'lng': position.longitude}
      });
      onSuccess!.call();
      return user.uid;
    } catch (e) {
      print('Failed to register: $e');
    }
  }
}
