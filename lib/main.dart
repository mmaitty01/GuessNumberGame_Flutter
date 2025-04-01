import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuessTheNumberPage(),
    );
  }
}

class GuessTheNumberPage extends StatefulWidget {
  @override
  _GuessTheNumberPageState createState() => _GuessTheNumberPageState();
}

class _GuessTheNumberPageState extends State<GuessTheNumberPage> {
  int _targetNumber = 0;
  int _guess = 0;
  String _message = 'Start the game! Guess a number between 1 and 100';
  TextEditingController _controller = TextEditingController();
  bool _isGameOver = false;
  Color _backgroundColor = Colors.white; // Default background color
  Color _textColor = Colors.white; // Default text color

  @override
  void initState() {
    super.initState();
    _generateNewNumber();
  }

  void _generateNewNumber() {
    var random = Random();
    _targetNumber = random.nextInt(100) + 1; // Generate a number between 1 and 100
    _message = 'New game started! Guess a number between 1 and 100';
    _backgroundColor = const Color.fromARGB(255, 16, 21, 42); // Reset background color
    _textColor = Colors.white; // Reset text color
    _isGameOver = false; // Reset game status
  }

  void _checkGuess() {
    setState(() {
      _guess = int.tryParse(_controller.text) ?? 0;
      if (_guess < _targetNumber) {
        _message = 'Your guess is too low!';
        _textColor = const Color.fromARGB(255, 254, 212, 0); // Change text color 
      } else if (_guess > _targetNumber) {
        _message = 'Your guess is too high!';
        _textColor = const Color.fromARGB(255, 243, 16, 103); // Change text color 
      } else {
        _message = '🎉 Congratulations! You guessed the number: $_targetNumber 🎉';
        _textColor = const Color.fromARGB(255, 0, 222, 82); // Change text color
        _isGameOver = true; // Set game over status
      }
      _controller.clear(); // Clear input field
    });
  }

  void _restartGame() {
    setState(() {
      _controller.clear();
      _generateNewNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Number Game'),
        backgroundColor: const Color.fromARGB(255, 210, 237, 242), // Blue button
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1), // Smooth transition animation
        color: _backgroundColor, // Background color changes
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _textColor, // Dynamic text color
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter your guess',
                  labelStyle: TextStyle(color: Colors.white38), // Light gray label
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 20 ,color: const Color.fromARGB(255, 185, 231, 255)), // Bigger input text
              ),
              SizedBox(height: 20),

              // Show the Guess Number button only if the game is not over
              if (!_isGameOver)
                ElevatedButton(
                  onPressed: _checkGuess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 227, 255), // Blue button
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Guess Number'),
                ),

              SizedBox(height: 20),

              // Show the Start New Game button if the game is over
              if (_isGameOver)
                ElevatedButton(
                  onPressed: _restartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 246, 151, 251), // Green button
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Start New Game'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
