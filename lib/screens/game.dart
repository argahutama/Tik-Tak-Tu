import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tik_tak_tu/dialog.dart';
import 'package:tik_tak_tu/components/game_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Game extends StatefulWidget {
  static const String id = 'game';
  @override
  _GameState createState() => new _GameState();
}

class _GameState extends State<Game> {
  List<GameButton> buttonsList;
  var you;
  var bot;
  var activePlayer;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    you = new List();
    bot = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gameButton) {
    setState(() {
      if (activePlayer == 1) {
        gameButton.text = "X";
        gameButton.bg = Colors.lightGreen;
        activePlayer = 2;
        you.add(gameButton.id);
      } else {
        gameButton.text = "O";
        gameButton.bg = Colors.lightBlue;
        activePlayer = 1;
        bot.add(gameButton.id);
      }
      gameButton.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialog(
                  "Masa imbang si, gampang loh wkwk 😭👎",
                  "Tekan ulangi untuk mengulang dari awal.",
                  resetGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(you.contains(cellID) || bot.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var random = new Random();
    var randIndex = random.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (you.contains(1) && you.contains(2) && you.contains(3)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(2) && bot.contains(3)) {
      winner = 2;
    }

    // row 2
    if (you.contains(4) && you.contains(5) && you.contains(6)) {
      winner = 1;
    }
    if (bot.contains(4) && bot.contains(5) && bot.contains(6)) {
      winner = 2;
    }

    // row 3
    if (you.contains(7) && you.contains(8) && you.contains(9)) {
      winner = 1;
    }
    if (bot.contains(7) && bot.contains(8) && bot.contains(9)) {
      winner = 2;
    }

    // col 1
    if (you.contains(1) && you.contains(4) && you.contains(7)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(4) && bot.contains(7)) {
      winner = 2;
    }

    // col 2
    if (you.contains(2) && you.contains(5) && you.contains(8)) {
      winner = 1;
    }
    if (bot.contains(2) && bot.contains(5) && bot.contains(8)) {
      winner = 2;
    }

    // col 3
    if (you.contains(3) && you.contains(6) && you.contains(9)) {
      winner = 1;
    }
    if (bot.contains(3) && bot.contains(6) && bot.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (you.contains(1) && you.contains(5) && you.contains(9)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(5) && bot.contains(9)) {
      winner = 2;
    }
    if (you.contains(3) && you.contains(5) && you.contains(7)) {
      winner = 1;
    }
    if (bot.contains(3) && bot.contains(5) && bot.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog(
                "Kamu menang. Tapi b aja, botnya gampang wkwk",
                "Tekan ulangi untuk mengulang dari awal.",
                resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog(
                "Kamu kalah, cemen banget! bot-nya gampang loh wkkw 😭👎",
                "Tekan ulangi untuk mengulang dari awal.",
                resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new SizedBox(
          height: 30.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 60.0,
              ),
            ),
            SizedBox(
              width: 250.0,
              child: FadeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [" Tik Tak Tu!", " by Arga"],
                textStyle: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        new SizedBox(
          height: 30.0,
        ),
        new Expanded(
          child: new GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0),
            itemCount: buttonsList.length,
            itemBuilder: (context, i) => new SizedBox(
              width: 100.0,
              height: 100.0,
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: buttonsList[i].enabled
                    ? () => playGame(buttonsList[i])
                    : null,
                child: new Text(
                  buttonsList[i].text,
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: buttonsList[i].bg,
                disabledColor: buttonsList[i].bg,
              ),
            ),
          ),
        ),
        new RaisedButton(
          child: new Text(
            "Keluar",
            style: new TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: Colors.red,
          padding: const EdgeInsets.all(20.0),
          onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          },
        )
      ],
    ));
  }
}
