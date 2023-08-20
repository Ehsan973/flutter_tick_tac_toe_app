import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;

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
              reset_game();
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
                height: 40,
              ),
              _getGridView(),
              _getTurn(),
            ],
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
              tapped(index);
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

  void reset_game() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void tapped(int index) {
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
  }

  void checkWinner() {
    //check rows
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      return;
    }

    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      return;
    }

    //check columns
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      return;
    }

    //check diagons
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      return;
    }

    //equality check
    if (filledBoxes == 9) {}
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
                '0',
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
                '0',
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
