import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;

    final loginText = isFilipino ? "MAG-LOGIN" : "LOGIN";
    final usernameHint = isFilipino ? "Pangalan ng Gumagamit" : "Username";
    final passwordHint = isFilipino ? "Password" : "Password";
    final forgotPassword = isFilipino ? "Nakalimutan ang Password?" : "Forgot Password?";
    final loginButton = isFilipino ? "MAG-LOGIN" : "LOGIN";
    final noAccount = isFilipino ? "Wala ka pang account? " : "Don't have an account? ";
    final signUpText = isFilipino ? "Mag-sign Up" : "Sign Up";

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loginText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Username Field
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: usernameHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: passwordHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(forgotPassword, style: const TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 10),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text(loginButton, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(noAccount),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    signUpText,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
