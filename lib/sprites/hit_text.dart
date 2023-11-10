import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/managers/hit_manager.dart';
import 'package:sample_app/timing_game.dart';

class HitText extends TextComponent with HasGameRef<TimingGame> {
  HitText({required this.positionX, required this.positionY})
      : super(
            anchor: Anchor.center,
            angle: radians(15),
            position: Vector2(positionX * 0.6, positionY * 0.45),
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 64)));

  final double positionX;
  final double positionY;

  bool isHit = false;
  HitType type = HitType.back;
  int counter = 0;

  @override
  void update(double dt) {
    _hitEvent();
    super.update(dt);
  }

  void onHit({required HitType hitType}) {
    isHit = true;
    type = hitType;
  }

  void _hitEvent() {
    text = 'Hit ${type.hitPoint}';
    counter++;
    textRenderer = TextPaint(
        style: TextStyle(
      fontSize: (64 + counter).toDouble(),
      color: Colors.white.withOpacity(1.0 - (counter * 0.1)),
    ));
    if (counter == 10) {
      isHit = false;
    }
    if (!isHit) {
      text = '';
      counter = 0;
    }
  }
}
