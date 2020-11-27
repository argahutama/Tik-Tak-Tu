import 'package:flutter/material.dart';
import 'package:tik_tak_tu/screens/homepage.dart';
import 'package:tik_tak_tu/screens/login.dart';
import 'package:tik_tak_tu/screens/sign_up.dart';
import 'package:tik_tak_tu/screens/game.dart';

void main() => runApp(TikTakTu());

class TikTakTu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Homepage.id,
      routes: {
        Homepage.id: (context) => Homepage(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        Game.id: (context) => Game(),
      },
    );
  }
}
