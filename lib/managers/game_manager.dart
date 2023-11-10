import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/managers/hit_manager.dart';
import 'package:sample_app/timing_game.dart';

class GameManager extends Component with HasGameRef<TimingGame> {
  GameState state = GameState.intro;

  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> tapCount = ValueNotifier(0);

  bool get isIntro => state == GameState.intro;

  bool get isPlaying => state == GameState.playing;

  bool get isGameOver => state == GameState.gameOver;

  bool get isGameClear => state == GameState.gameClear;

  void reset() {
    state = GameState.intro;
    score.value = 0;
    tapCount.value = 0;
  }

  void hit({required HitType hitType}) {
    score.value += hitType.hitPoint;
    tapCount.value++;
    if (tapCount.value == 10) {
      if (score.value >= 100) {
        state = GameState.gameClear;
      } else {
        state = GameState.gameOver;
      }
    }
  }
}

enum GameState {
  intro,
  playing,
  gameOver,
  gameClear;
}
