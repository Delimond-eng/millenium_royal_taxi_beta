import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/user.dart';
import '../screens/auth/states/auth_state.dart';

class UserRepository {
  UserRepository._();
  static UserRepository? _instance;

  static UserRepository get instance {
    _instance ??= UserRepository._();
    return _instance!;
  }

  Roles? get currentUserRole => currentUser?.role;

  var userState = Get.put(AuthState());

  User? get currentUser {
    return null;
  }

  Future<User?> setUpAccount(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'email': user.email,
      'firstname': user.firstname,
      'lastname': user.lastname,
      'role': user.role.index,
      'is_verified': user.isVerified,
      'is_active': user.isActive,
      'latlng': {
        'lat': user.latlng?.latitude,
        'lng': user.latlng?.longitude,
      },
    });
    //userNotifier.value = await UserRepository.instance.getUser(user.uid);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

    //return userNotifier.value;
    return null;
  }

  /// GET USER BY UID
  /// @param String uid
  Future<User?> getUser(String? uid) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!userSnapshot.exists) {
      return null;
    } else {
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
      if (kDebugMode) {
        print(data);
      }
      //userNotifier.value = User.fromMap(data);
    }
    //return userNotifier.value;
    return null;
  }

  Future<void> signInCurrentUser() async {
    if (UserRepository.instance.currentUser == null) {
      auth.User? authUser = auth.FirebaseAuth.instance.currentUser;
      if (authUser == null) {
        if (kDebugMode) {
          print("no current user");
        }
        try {
          authUser = await auth.FirebaseAuth.instance.authStateChanges().first;
        } catch (_) {}
      }
      if (authUser == null) {
        print("no state change user");
      } else {
        await UserRepository.instance.getUser(authUser.uid);
      }
    }
  }

  Future<User?> updateDriverLocation(String? uid, LatLng position) async {
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'latlng': {
          'lat': position.latitude,
          'lng': position.longitude,
        },
      });
      //return userNotifier.value;
      return null;
    }
    return null;
  }

  Future<User?> updateOnlinePresense(String? uid, bool isActive) async {
    if (uid != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'is_active': isActive});
      //return userNotifier.value;
      return null;
    }
    return null;
  }
}
