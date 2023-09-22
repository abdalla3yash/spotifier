import 'package:flutter/material.dart';
import 'package:spotifier/common/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        defaultAppBar(context),
      ]),
    );
  }
}
