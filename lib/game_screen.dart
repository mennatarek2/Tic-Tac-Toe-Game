import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/welcome_screen.dart';
import 'package:tic_tac_toe_game/xo_button.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});
  static const String routeName = '/gameScreen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameScreenArguments arguments;
  int player1Score = 0;
  int player2Score = 0;
  String? winner;
  List<String> boardState = ["", "", "", "", "", "", "", "", ""];
  int counter = 0;

  String get currentPlayer {
    return counter.isEven ? "Player 1" : "Player 2";
  }

  String get currentPlayerSymbol {
    return counter.isEven ? arguments.firstPlayer : arguments.secondPlayer;
  }

  void onClick(int index) {
    if (boardState[index] != "" || winner != null) {
      return; // If the cell is already occupied or game is won, do nothing
    }
    if (counter.isEven) {
      boardState[index] = arguments.firstPlayer;
    } else {
      boardState[index] = arguments.secondPlayer;
    }

    if (checkWinner("X")) {
      if (arguments.firstPlayer == "X") {
        player1Score++;
        winner = "Player 1";
      } else {
        player2Score++;
        winner = "Player 2";
      }
    } else if (checkWinner("O")) {
      if (arguments.firstPlayer == "O") {
        player1Score++;
        winner = "Player 1";
      } else {
        player2Score++;
        winner = "Player 2";
      }
    } else if (counter == 8) {
      // counter starts from 0, so 8 means 9 moves
      winner = "Draw";
    }

    counter++;
    setState(() {});
  }

  bool checkWinner(String symbol) {
    for (int i = 0; i < 7; i += 3) {
      // Check rows
      if (boardState[i] == symbol &&
          boardState[i + 1] == symbol &&
          boardState[i + 2] == symbol) {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      // Check columns
      if (boardState[i] == symbol &&
          boardState[i + 3] == symbol &&
          boardState[i + 6] == symbol) {
        return true;
      }
    }
    // Check diagonals
    if (boardState[0] == symbol &&
        boardState[4] == symbol &&
        boardState[8] == symbol) {
      return true;
    }
    if (boardState[2] == symbol &&
        boardState[4] == symbol &&
        boardState[6] == symbol) {
      return true;
    }
    return false;
  }

  void resetBoard() {
    setState(() {
      boardState = ["", "", "", "", "", "", "", "", ""];
      counter = 0;
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as GameScreenArguments;
    // This line is used to retrieve any arguments passed to the route, if needed.
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF0dbff6),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if (winner == null) ...[
                      Text(
                        '$currentPlayer\'s Turn',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '(${currentPlayerSymbol})',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ] else if (winner == "Draw") ...[
                      Text(
                        'It\'s a Draw!',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      Text(
                        '$winner Wins!',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Score: ${winner == "Player 1" ? player1Score : player2Score}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'P1 : $player1Score',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'P2 : $player2Score',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (winner != null) ...[
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: resetBoard,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF3A7BD5),
                        ),
                        child: Text(
                          'Play Again',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                XoButton(
                                  symbol: boardState[0],
                                  index: 0,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[1],
                                  index: 1,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[2],
                                  index: 2,
                                  onClick: onClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                XoButton(
                                  symbol: boardState[3],
                                  index: 3,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[4],
                                  index: 4,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[5],
                                  index: 5,
                                  onClick: onClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                XoButton(
                                  symbol: boardState[6],
                                  index: 6,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[7],
                                  index: 7,
                                  onClick: onClick,
                                ),
                                XoButton(
                                  symbol: boardState[8],
                                  index: 8,
                                  onClick: onClick,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
