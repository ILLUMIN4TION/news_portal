import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget child;
  const AppScaffold({super.key, required this.child, this.appbar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar, body: SafeArea(child: child));
  }
}
