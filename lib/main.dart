import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'create_product_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/', // Start from LoginScreen
//       routes: {
//         '/': (context) => const LoginScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/signup': (context) => const SignUpScreen(),
//       },
//     );
//   }
// }



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getThemeData(appState.theme),
     routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}