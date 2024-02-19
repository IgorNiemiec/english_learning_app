import 'package:english_learning_app/app.dart';
import 'package:english_learning_app/firebase_options.dart';
import 'package:english_learning_app/views/login_view.dart';
import 'package:english_learning_app/views/main_panel_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}


