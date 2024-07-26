import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:royal_taxi_beta/firebase_options.dart';
import 'package:royal_taxi_beta/services/location_service.dart';
import '/route/route_constants.dart';
import '/route/router.dart' as router;
import '/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationService.requestAllow();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Royal Taxi application',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: logInScreenRoute,
      builder: EasyLoading.init(),
    );
  }
}
