import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget desktop;
  final Widget? desktopLarge;

  const Responsive({
    Key? key,
    required this.mobile,
    this.mobileLarge,
    this.tablet,
    required this.desktop,
    this.desktopLarge,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
          MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850 &&
          MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isDesktopLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1440;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1440 && desktopLarge != null) {
          return desktopLarge!;
        } else if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 850 && tablet != null) {
          return tablet!;
        } else if (constraints.maxWidth >= 650 && mobileLarge != null) {
          return mobileLarge!;
        } else {
          return mobile;
        }
      },
    );
  }
}
