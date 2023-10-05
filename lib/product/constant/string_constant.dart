// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

@immutable
class StringConstant {
  const StringConstant._();
  static const String appName = 'Flutter News';
  static const String homeViewTitle = 'Home View';

  // Login
  static const loginWelcomeBack = 'Welcome Back 👋';
  static const loginWelcomeDetail =
      'I am happy to see you again. You can continue where you left off by logging in';

  static const continueToApp = 'Continue to app';

  // Home
  static const homeBrowse = 'Browse';
  static const homeMessage =
      'I am happy to see you again. You can continue where you left off by logging in';

  static const homeTitle = 'Recommended for you';
  static const homeSeeAll = 'See all';
  static const homeSearchHint = 'Search';
  static const addItemTitle = 'Add new item';

  // Component
  static const String dropdownHint = 'Select Items';
  static const String dropdownTitle = 'Title';
  static const String buttonSave = 'Save';
}
