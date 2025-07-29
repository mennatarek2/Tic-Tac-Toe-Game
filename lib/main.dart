import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/welcome_screen.dart';
import 'game_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.routeName: (context) =>  WelcomeScreen(),
        GameScreen.routeName: (context) =>  GameScreen(),

      },
      initialRoute: WelcomeScreen.routeName,

      debugShowCheckedModeBanner: false,
    );
  }
}
