import 'package:flutter/material.dart';
import 'login.dart';
import 'sign_up.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tik_tak_tu/components/rounded_button.dart';

class Homepage extends StatefulWidget {
  static const String id = 'homepage';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                FadeAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [" Tik Tak Tu!", " by Arga"],
                  textStyle: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Masuk',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, Login.id);
              },
            ),
            RoundedButton(
              title: 'Daftar',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, SignUp.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
