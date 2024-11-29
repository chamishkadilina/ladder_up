import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ladder_up/navigation_bar.dart';
import 'package:ladder_up/pages/login_or_signin_page.dart';
import 'package:ladder_up/providers/auth_provider.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ladder Up',
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.isAuthenticated
              ? const MyNavigationBar()
              : const LoginPage();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
