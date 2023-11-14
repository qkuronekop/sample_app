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
    final levelManager = gameRef.levelManager;
    levelManager.reset();
    gameRef.barMiddle.reset();
    gameRef.barCenter.reset();
    gameRef.enemy.reloadImage();
  }

  void scoreReset() {
    score.value = 0;
    tapCount.value = 0;
  }

  void hit({required HitType hitType}) {
    score.value += _score(hitType: hitType);
    tapCount.value++;
    if (tapCount.value == 10 || score.value >= 100) {
      if (score.value >= 100) {
        state = GameState.gameClear;
      } else {
        state = GameState.gameOver;
      }
    }
  }

  int _score({required HitType hitType}) {
    final level = gameRef.levelManager;
    switch (hitType) {
      case HitType.back:
        return level.barLevel.backPoint;
      case HitType.middle:
        return level.barLevel.middlePoint;
      case HitType.center:
        return level.barLevel.centerPoint;
    }
  }
}

enum GameState {
  intro,
  playing,
  gameOver,
  gameClear;
}
