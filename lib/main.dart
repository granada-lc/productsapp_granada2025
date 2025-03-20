import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'create_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Start from LoginScreen
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'create_product_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/create-product': (context) => const CreateProductScreen(),
//       },
//       home: const CreateProductScreen(), // Set initial screen for testing
//     );
//   }
// }  
