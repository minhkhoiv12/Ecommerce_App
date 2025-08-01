import 'package:bai1/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _authController.signOutUser(context: context);
        }, child: Text('Sign Out'),
    ),
    );
  }
}