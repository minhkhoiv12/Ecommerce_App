import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const String id = '\order-screen'; 
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Text(
        "Order Screen",
      ),
    );
  }
}