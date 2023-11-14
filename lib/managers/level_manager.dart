import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/timing_game.dart';

class LevelManager extends Component with HasGameRef<TimingGame> {
  int level = 1;

  BarLevel get barLevel => BarLevel.values[level - 1];

  ValueNotifier<int> myLevel = ValueNotifier(1);

  void levelUp() {
    level++;
    myLevel.value = level;
  }

  void reset() {
    level = 1;
    myLevel.value = 1;
  }
}

enum BarLevel {
  level1(0.5, 0.07, 5, 10, 15, 1),
  level2(0.4, 0.06, 0, 10, 15, 1.2),
  level3(0.3, 0.05, 0, 5, 20, 1.5);

  const BarLevel(this.middleRatio, this.centerRatio, this.backPoint,
      this.middlePoint, this.centerPoint, this.speed);

  final double middleRatio;
  final double centerRatio;
  final int backPoint;
  final int middlePoint;
  final int centerPoint;
  final double speed;
}
