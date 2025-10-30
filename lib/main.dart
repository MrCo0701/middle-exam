import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:middle_exam/feature/authentication/presentation/login_screen.dart';
import 'package:middle_exam/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}