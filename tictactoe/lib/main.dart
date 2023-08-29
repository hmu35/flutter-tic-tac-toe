import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartoon Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  String currentPlayer = 'X';
  bool gameOver = false;

  void _makeMove(int row, int col) {
    if (board[row][col] == '' && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        if (_checkForWin(row, col)) {
          gameOver = true;
          _showDialog('Player $currentPlayer wins!');
        } else if (_boardIsFull()) {
          gameOver = true;
          _showDialog('It\'s a draw!');
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkForWin(int row, int col) {
    // Check row
    if (board[row][0] == board[row][1] &&
        board[row][0] == board[row][2] &&
        board[row][0] != '') {
      return true;
    }

    // Check column
    if (board[0][col] == board[1][col] &&
        board[0][col] == board[2][col] &&
        board[0][col] != '') {
      return true;
    }

    // Check diagonals
    if ((board[0][0] == board[1][1] &&
            board[0][0] == board[2][2] &&
            board[0][0] != '') ||
        (board[0][2] == board[1][1] &&
            board[0][2] == board[2][0] &&
            board[0][2] != '')) {
      return true;
    }

    return false;
  }

  bool _boardIsFull() {
    for (var row in board) {
      if (row.contains('')) {
        return false;
      }
    }
    return true;
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _resetGame();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
    gameOver = false;
  }
  // ... (same reset game logic as before)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int row = 0; row < 3; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int col = 0; col < 3; col++)
                    GestureDetector(
                      onTap: () => _makeMove(row, col),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Text(
                            board[row][col],
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
