import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/firebase_options.dart';

@immutable
class Applicationstart {
  const Applicationstart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.instance.initPackageInfo();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
