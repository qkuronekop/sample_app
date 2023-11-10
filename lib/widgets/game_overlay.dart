import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/timing_game.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay({super.key, required this.game});

  final Game game;

  @override
  State createState() => _State();
}

class _State extends State<GameOverlay> {
  @override
  Widget build(BuildContext context) {
    TimingGame timingGame = widget.game as TimingGame;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 60,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: timingGame.gameManager.tapCount,
                  builder: (context, value, child) {
                    return Text(
                      '$value / 10 回',
                      style: const TextStyle(fontSize: 24),
                    );
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                ValueListenableBuilder(
                  valueListenable: timingGame.gameManager.score,
                  builder: (context, value, child) {
                    return Text(
                      'HitPoint $value / 100',
                      style: const TextStyle(fontSize: 24),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 80,
              width: timingGame.size.x / 2,
              right: timingGame.size.x / 4,
              child: ElevatedButton(
                onPressed: () {
                  timingGame.onPress();
                },
                child: const Text(
                  'Press',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ))
        ],
      ),
    );
  }
}
