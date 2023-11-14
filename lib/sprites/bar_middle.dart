import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:sample_app/timing_game.dart';

class BarMiddle extends RectangleComponent with HasGameRef<TimingGame> {
  BarMiddle({required this.positionX, required this.sizeX})
      : super(
          paint: BasicPalette.darkBlue.paint(),
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
    size = Vector2(sizeX * barLevel.middleRatio, 40);
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
    size = Vector2(sizeX * barLevel.middleRatio, 40);
  }

  void reset() {
    final barLevel = gameRef.levelManager.barLevel;
    size = Vector2(sizeX * barLevel.middleRatio, 40);
  }

  void _blinking() {
    if (isBlinking) {
      paint = BasicPalette.white.paint();
      isBlinking = false;
    } else {
      paint = BasicPalette.darkBlue.paint();
    }
  }
}
