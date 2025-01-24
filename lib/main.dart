import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ladder_up/navigation_bar.dart';
import 'package:ladder_up/pages/login_or_signin_page.dart';
import 'package:ladder_up/providers/auth_provider.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/providers/setting_provider.dart';
import 'package:ladder_up/providers/target_provider.dart';
import 'package:ladder_up/services/notification_service.dart';
import 'package:ladder_up/services/storage_service.dart';
import 'package:ladder_up/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init();
  await StorageService.init();
  tz.initializeTimeZones();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => TargetProvider()),
      ],
      child: const MyApp(),
    ),
  );

  // Schedule task notifications
  final projectProvider = ProjectProvider();
  await projectProvider.scheduleTaskNotifications();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme
      themeMode: context.watch<SettingsProvider>().themeMode,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,

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
