import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productapp_granada2025/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'app_state.dart';
import 'config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _login(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    final isFilipino = appState.language == AppLanguage.filipino;

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFilipino
              ? "Pakitapos ang lahat ng fields."
              : "Please complete all fields."),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userId = responseData['user']['id'];
        final username = responseData['user']['username'];
        final email = responseData['user']['email'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userId);
        await prefs.setString('user_name', username ?? 'User Name');
        await prefs.setString('user_email', email ?? 'user@example.com');

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                isFilipino ? "Maling kredensyal." : "Invalid credentials."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              isFilipino ? "May problema sa koneksyon." : "Connection error."),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;

    final loginText = isFilipino ? "MAG-LOGIN" : "LOGIN";
    final usernameHint = isFilipino ? "Pangalan ng Gumagamit" : "Username";
    final passwordHint = isFilipino ? "Password" : "Password";
    final forgotPassword =
        isFilipino ? "Nakalimutan ang Password?" : "Forgot Password?";
    final loginButton = isFilipino ? "MAG-LOGIN" : "LOGIN";
    final noAccount =
        isFilipino ? "Wala ka pang account? " : "Don't have an account? ";
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
              controller: _usernameController,
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
              controller: _passwordController,
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
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(forgotPassword,
                    style: const TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 10),

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
                onPressed: _isLoading ? null : () => _login(context),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        loginButton,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),
            const SizedBox(height: 20),

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
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
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
