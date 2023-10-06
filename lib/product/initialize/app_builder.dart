import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBuilder {
  AppBuilder(this.child);

  final Widget? child;

  Widget build() {
    return ResponsiveBreakpoints.builder(
      child : child!,
      // maxWidth: 1200,
      // minWidth: 480,
      // defaultScale: true,
      breakpoints: [
        const Breakpoint(start:0,end: 480, name: MOBILE),
        const Breakpoint(start:481,end:800, name: TABLET),
        const Breakpoint(start:801,end:1200, name: DESKTOP),
      ],
       
    );
  }
}
