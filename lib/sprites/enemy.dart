import 'package:flame/components.dart';
import 'package:sample_app/timing_game.dart';

class Enemy extends SpriteComponent with HasGameRef<TimingGame> {
  Enemy({required this.positionX, required this.positionY})
      : super(
            size: Vector2(300, 300),
            anchor: Anchor.center,
            position: Vector2(positionX / 2, positionY * 0.6));

  final double positionX;
  final double positionY;

  bool isHit = false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await _loadCharacterSprites();
  }

  @override
  void update(double dt) {
    _hitEffect();
    super.update(dt);
  }

  Future<void> _loadCharacterSprites() async {
    final level = gameRef.levelManager.level;
    switch (level) {
      case 1:
        sprite = await gameRef.loadSprite('game/dragon_ rock_.png');
        break;
      case 2:
        sprite =
            await gameRef.loadSprite('game/light-and-darkness-dragon_1.png');
        break;
      case 3:
        sprite = await gameRef.loadSprite('game/magic-dragon_1.png');
        break;
    }
  }

  void reloadImage() {
    _loadCharacterSprites();
  }

  void onHitEvent() {
    isHit = true;
  }

  void _hitEffect() {
    if (isHit) {
      opacity = 0.1;
      position = Vector2(position.x + 10, position.y - 10);
      Future.delayed(const Duration(milliseconds: 100), () {
        position = Vector2(position.x - 10, position.y + 10);
      });
      isHit = false;
    } else {
      opacity = 1.0;
      // remove(hitEffect);
    }
  }
}
