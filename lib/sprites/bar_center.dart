import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:sample_app/timing_game.dart';

class BarCenter extends RectangleComponent with HasGameRef<TimingGame> {
  BarCenter({required this.positionX, required this.sizeX})
      : super(
          paint: BasicPalette.red.paint(),
          anchor: Anchor.center,
        ) {
    position = Vector2(positionX, 200);
  }

  final double positionX;
  final double sizeX;

  bool isBlinking = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final barLevel = gameRef.levelManager.barLevel;
    size = Vector2(sizeX * barLevel.centerRatio, 40);
  }

  @override
  void update(double dt) {
    _blinking();
    super.update(dt);
  }

  void onBlinking() {
    isBlinking = true;
  }

  void levelUp() {
    final barLevel = gameRef.levelManager.barLevel;
    size = Vector2(sizeX * barLevel.centerRatio, 40);
  }

  void reset() {
    final barLevel = gameRef.levelManager.barLevel;
    size = Vector2(sizeX * barLevel.centerRatio, 40);
  }

  void _blinking() {
    if (isBlinking) {
      paint = BasicPalette.white.paint();
      isBlinking = false;
    } else {
      paint = BasicPalette.red.paint();
    }
  }
}
