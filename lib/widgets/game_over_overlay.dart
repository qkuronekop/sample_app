import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/managers/game_manager.dart';
import 'package:sample_app/timing_game.dart';

class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay({super.key, required this.game});

  final Game game;

  @override
  State createState() => _State();
}

class _State extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    TimingGame game = widget.game as TimingGame;
    return Material(
      color: Colors.black,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Game Over 💣',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                game.gameStart();
              },
              child: const Text(
                '最初から',
                style: TextStyle(fontSize: 24),
              )),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                game.gameManager.state = GameState.intro;
              },
              child: const Text(
                'タイトルへ戻る',
                style: TextStyle(fontSize: 24),
              )),
        ],
      )),
    );
  }
}
