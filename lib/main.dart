import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/feature/home/home_view.dart';
import 'package:riverpod_project/product/constant/string_constant.dart';
import 'package:riverpod_project/product/initialize/app_builder.dart';
import 'package:riverpod_project/product/initialize/app_theme.dart';

import 'package:riverpod_project/product/initialize/application_start.dart';

void main() async {
  await Applicationstart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => AppBuilder(child).build(),
      debugShowCheckedModeBanner: false,
      title: StringConstant.appName,
      home: const HomeView(),
      theme: AppTheme(context).theme,
    );
  }
}
