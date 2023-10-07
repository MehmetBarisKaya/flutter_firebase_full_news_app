import 'package:flutter/material.dart';
import 'package:riverpod_project/feature/home/home_create/home_create_view.dart';

mixin LoadingMixin on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
