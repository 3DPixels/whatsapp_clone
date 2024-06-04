import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/theme/dark_theme.dart';
import 'package:whatsapp_clone/common/theme/light_theme.dart';
import 'package:whatsapp_clone/feature/auth/pages/login_page.dart';
import 'package:whatsapp_clone/feature/auth/pages/user_info_page.dart';
import 'package:whatsapp_clone/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_clone/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp mazengar',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      onGenerateRoute: Routes.onGenerateRoute,
      home: const WelcomePage(),
    );
  }
}
