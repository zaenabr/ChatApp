import 'package:flutter/material.dart';
import 'package:untitled2/screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/setting_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlashChat());
  await Firebase.initializeApp();

}

  class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(

   initialRoute: 'welcome_screen',
   routes: {
     'welcome_screen': (context) => WelcomeScreen(),
     'login_screen': (context) => LoginScreen(),
     'registration_screen': (context) => RegistrationScreen(),
     'chat_screen': (context) => ChatScreen(),
     'home_screen': (context) => HomeScreen(),
     'setting_screen': (context) => SettingScreen(),
  },
  );

  }
  }
