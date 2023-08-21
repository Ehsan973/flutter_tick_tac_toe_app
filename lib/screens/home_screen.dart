import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  int xScore = 0;
  int oScore = 0;

  bool gameHasResult = false;
  String winnerTitle = '';

  var xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 0,
        title: Text(
          'TicTacToe',
        ),
        actions: [
          IconButton(
            onPressed: () {
              _resetGame();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _getScoreBoard(),
              SizedBox(
                height: gameHasResult ? 25 : 40,
              ),
              _getResultButton(),
              SizedBox(
                height: 10,
              ),
              _getGridView(),
              _getTurn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            gameHasResult = false;
            _clearGame();
          });
        },
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'turn O' : 'turn X',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  '${xOrOList[index]}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: xOrOList[index] == 'X' ? Colors.white : Colors.red,
                    fontSize: 70,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _resetGame() {
    _clearGame();
    setState(() {
      xScore = 0;
      oScore = 0;
      gameHasResult = false;
    });
  }

  void _clearGame() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
      isTurnO = true;
    });
    filledBoxes = 0;
  }

  void _tapped(int index) {
    if (gameHasResult) return;
    if (xOrOList[index] != '') return;

    if (isTurnO) {
      setState(() {
        xOrOList[index] = 'O';
        filledBoxes++;
        isTurnO = !isTurnO;
      });
    } else {
      setState(() {
        xOrOList[index] = 'X';
        filledBoxes++;
        isTurnO = !isTurnO;
      });
    }

    _checkWinner();
  }

  void _checkWinner() {
    //check rows
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0]);
      return;
    }

    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      _setResult(xOrOList[3]);
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      _setResult(xOrOList[6]);

      return;
    }

    //check columns
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0]);

      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      _setResult(xOrOList[1]);

      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2]);

      return;
    }

    //check diagons
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0]);

      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2]);
      return;
    }

    //equality check
    if (filledBoxes == 9) {
      _setResult('');
    }
  }

  void _setResult(String winner) {
    setState(() {
      gameHasResult = true;
      if (winner == 'O') {
        winnerTitle = 'winner is O';
        oScore++;
      } else if (winner == 'X') {
        winnerTitle = 'winner is X';
        xScore++;
      } else {
        winnerTitle = 'Draw';
        oScore++;
        xScore++;
      }
    });
  }

  Widget _getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Player O',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '$oScore',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Player X',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '$xScore',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
