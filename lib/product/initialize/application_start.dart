import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/firebase_options.dart';
import 'package:riverpod_project/product/initialize/app_cache.dart';

@immutable
class Applicationstart {
  const Applicationstart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.instance.initPackageInfo();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(clientId: 'GOOGLE_CLIENT_ID'),
    ]);

    await AppCache.instance.setUp();
  }
}
