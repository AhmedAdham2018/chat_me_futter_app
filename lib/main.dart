import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_me/screens/welcome_screen.dart';
import 'package:chat_me/screens/home_screen.dart';
import 'package:chat_me/screens/register_screen.dart';
import 'package:chat_me/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatMeApp());
}

class ChatMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
          bodyText1: TextStyle(color: Colors.black54),
          subtitle1: TextStyle(color: Colors.black),
          subtitle2: TextStyle(color: Colors.black38),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
