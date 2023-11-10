import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class BarCenter extends RectangleComponent {
  BarCenter({required this.positionX, required this.sizeX})
      : super(
          paint: BasicPalette.red.paint(),
          anchor: Anchor.center,
        ) {
    position = Vector2(positionX, 200);
    size = Vector2(sizeX * 0.07, 40);
  }

  final double positionX;
  final double sizeX;

  bool isBlinking = false;

  @override
  void update(double dt) {
    _blinking();
    super.update(dt);
  }

  void onBlinking() {
    isBlinking = true;
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
