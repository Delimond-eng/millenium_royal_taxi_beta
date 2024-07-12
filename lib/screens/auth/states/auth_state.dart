import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/user.dart';

enum PhoneAuthState { initial, success, loading, codeSent, error }

class AuthState extends GetxController {
  static AuthState instance = Get.find();

  PhoneAuthState _phoneAuthState = PhoneAuthState.initial;

  var verificationId = ''.obs;

  var phoneController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var referralCodeController = TextEditingController().obs;
  var otpController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
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

  void animateToNextPage(int page) {
    controller.value.animateToPage(page,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    pageIndex.value = page;
  }

  void onPageChanged(int value) {
    pageIndex.value = value;
  }

  Future<void> signUp() async {
    phoneAuthStateChange = PhoneAuthState.loading;
    /*final address = await MapService.instance?.getCurrentPosition();
    try {
      final user = User(
        uid: uid,
        isActive: true,
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        createdAt: DateTime.now(),
        isVerified: true,
        licensePlate: licensePlateController.text,
        phone: "234${phoneController.text}",
        vehicleType: vehicleTypeController.text,
        vehicleColor: vehicleColorController.text,
        vehicleManufacturer: vehicleManufacturersController.text,
        role: role,
        latlng: address?.latLng,
      );
      await userRepo.setUpAccount(user);
      phoneAuthStateChange = PhoneAuthState.success;
    } on FirebaseException catch (e) {
      print(e.message);
      phoneAuthStateChange = PhoneAuthState.error;
    }*/
  }

  Future<void> phoneNumberVerification(String phone) async {
    /*await AuthService.instance!.verifyPhoneSendOtp(phone,
        completed: (credential) async {
      if (credential.smsCode != null && credential.verificationId != null) {
        verificationId = credential.verificationId ?? '';
        notifyListeners();
        await verifyAndLogin(credential.verificationId!, credential.smsCode!,
            phoneController.text);
      }
    }, failed: (error) {
      phoneAuthStateChange = PhoneAuthState.error;
    }, codeSent: (String id, int? token) {
      verificationId = id;
      notifyListeners();

      phoneAuthStateChange = PhoneAuthState.codeSent;
      codeSentEvent();
      print('code sent $id');
    }, codeAutoRetrievalTimeout: (id) {
      verificationId = id;
      notifyListeners();

      phoneAuthStateChange = PhoneAuthState.codeSent;
      animateToNextPage(1);
      print('timeout $id');
    });
    animateToNextPage(1);*/
  }

  Future<void> verifyAndLogin(
      String verificationId, String smsCode, String phone) async {
    /*phoneAuthStateChange = PhoneAuthState.loading;
    final uid =
        await authService?.verifyAndLogin(verificationId, smsCode, phone);
    await userRepo.getUser(uid);
    this.uid = uid ?? '';
    animateToNextPage(2);
    phoneAuthStateChange = PhoneAuthState.success;*/
  }

  Future<void> siginCurrentUser() async {
    //await userRepo.signInCurrentUser();
  }

  Future<void> codeSentEvent() async {
    animateToNextPage(1);
    //_startCountDown();
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
  Future<dynamic> signInWithPhoneAndPassword() async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneController.value.text)
          .where('password', isEqualTo: passwordController.value.text)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // L'utilisateur existe et le mot de passe est correct
        auth.UserCredential userCredential =
            await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userQuery.docs[0]['email'],
          password: passwordController.value.text,
        );

        String uid = userCredential.user!.uid;
        return uid;
      } else {
        // L'utilisateur n'existe pas ou le mot de passe est incorrect
        return null;
      }
    } catch (e) {
      print('Failed to sign in: $e');
      return null;
    }
  }

  //Verify phoneNumber
  Future<void> verifyPhoneNumber() async {
    auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+243${phoneController.value.text}',
      verificationCompleted: (auth.PhoneAuthCredential credential) async {
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (auth.FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
        otpVerifyId.value = "";
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVerifyId.value = verificationId;
        animateToNextPage(2);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //Verify otp
  Future<bool> signInWithOtp(BuildContext context, String otp) async {
    auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
      verificationId: otpVerifyId.value,
      smsCode: otp,
    );
    try {
      auth.UserCredential userCredential =
          await auth.FirebaseAuth.instance.signInWithCredential(credential);
      auth.User? user = userCredential.user;
      if (kDebugMode) {
        print(user);
      }
      animateToNextPage(3);
      return true;
    } catch (e) {
      otpfailed.value = "failed";
      print('Failed to sign in: $e');
    }
    return false;
  }

  //Register user
  Future<dynamic> registerUser(BuildContext context) async {
    if (passwordController.value.text != confirmPasswordController.value.text) {
      print('Passwords do not match');
      return;
    }
    try {
      // Créez un utilisateur anonyme pour obtenir un UID
      var user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No current user after phone verification');
        return;
      }
      String email = emailController.value.text;
      // Mettez à jour l'adresse e-mail et le mot de passe
      await user.verifyBeforeUpdateEmail(email);
      await user.updatePassword(passwordController.value.text);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': firstNameController.value.text,
        'lastName': lastNameController.value.text,
        'email': emailController.value.text,
        'phoneNumber': phoneController.value.text,
        'referralCode': referralCodeController..value.text,
        'password': passwordController.value.text,
        'is_active': true,
        'latlng': {'lat': '9393030', 'lng': '8383893'}
      });
      return user.uid;
    } catch (e) {
      print('Failed to register: $e');
    }
  }
}
