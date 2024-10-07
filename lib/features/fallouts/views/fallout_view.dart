import 'package:flutter/material.dart';
import 'package:recipe_book/core/constants.dart';

class FalloutView extends StatelessWidget {
  const FalloutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              AppStrings.connectErrorMessage,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
