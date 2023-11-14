import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:sample_app/timing_game.dart';

class Player extends RectangleComponent with HasGameRef<TimingGame> {
  Player({required this.positionX, required this.sizeX})
      : super(
          paint: BasicPalette.yellow.paint(),
          anchor: Anchor.center,
        ) {
    position = Vector2(positionX, 200);
    size = Vector2(sizeX * 0.02, 40);
  }

  final double positionX;
  final double sizeX;

  bool isRight = false;

  @override
  void update(double dt) {
    _move(dt);
    super.update(dt);
  }

  void _move(double dt) {
    final level = gameRef.levelManager.barLevel;
    double direction = 1;
    double speed = level.speed;
    final velocity = Vector2(positionX, 200);
    final barStart = (gameRef.size.x * 0.1) / 2;
    final barWidth = gameRef.size.x * 0.9 + barStart;
    velocity.y = direction;
    // print('barStart -> $barStart : position.x -> ${position.x}');
    if (position.x.ceil() <= barStart.ceil()) {
      isRight = true;
    }

    if (position.x.ceil() >= barWidth.ceil()) {
      isRight = false;
    }
    if (isRight) {
      position += velocity * dt * speed;
    } else {
      position -= velocity * dt * speed;
    }
  }
}
