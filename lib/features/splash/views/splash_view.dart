// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController _splashController = SplashController();
  int _currentIconIndex = 0;
  late Timer _iconTimer;

  final List<IconData> _foodIcons = [
    fluent.FluentIcons.cake,
    fluent.FluentIcons.breakfast,
    fluent.FluentIcons.cocktails,
  ];

  @override
  void initState() {
    super.initState();
    _splashController.initialize(context);
    _startIconRotation();
  }

  @override
  void dispose() {
    _iconTimer.cancel();
    super.dispose();
  }

  void _startIconRotation() {
    _iconTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentIconIndex = (_currentIconIndex + 1) % _foodIcons.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _foodIcons[_currentIconIndex],
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Yum... Yum!',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
