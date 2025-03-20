import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.pink[100],
      ),
      body: const Center(
        child: Text("Sign Up Screen"),
      ),
    );
  }
}
