import 'package:flame/game.dart';
import 'package:sample_app/main.dart';
import 'package:sample_app/managers/game_manager.dart';
import 'package:sample_app/managers/hit_manager.dart';
import 'package:sample_app/managers/level_manager.dart';
import 'package:sample_app/sprites/bar_back.dart';
import 'package:sample_app/sprites/bar_center.dart';
import 'package:sample_app/sprites/bar_middle.dart';
import 'package:sample_app/sprites/enemy.dart';
import 'package:sample_app/sprites/hit_text.dart';
import 'package:sample_app/sprites/player.dart';

class TimingGame extends FlameGame {
  GameManager gameManager = GameManager();
  HitManager hitManager = HitManager();
  LevelManager levelManager = LevelManager();
  late Player player;
  late BarBack barBack;
  late BarMiddle barMiddle;
  late BarCenter barCenter;
  late Enemy enemy;
  late HitText hitText;

  @override
  Future<void> onLoad() async {
    await add(gameManager);
    await _setCharacter();
    await add(hitManager);
    await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    overlays.add(gameOverlay);

    if (gameManager.isIntro) {
      overlays.add(mainMenuOverlay);
      return;
    }

    if (gameManager.isGameClear) {
      overlays.add(clearOverlay);
      return;
    }

    if (gameManager.isGameOver) {
      overlays.add(gameOverOverlay);
      return;
    }
  }

  void gameStart() {
    gameManager.reset();
    gameManager.state = GameState.playing;
    overlays.remove(mainMenuOverlay);
    overlays.remove(clearOverlay);
    overlays.remove(gameOverOverlay);
  }

  void reset() {
    gameManager.reset();
  }

  void levelUp() {
    gameManager.scoreReset();
    levelManager.levelUp();
    barMiddle.levelUp();
    barCenter.levelUp();
    enemy.reloadImage();
    gameManager.state = GameState.playing;
    overlays.remove(mainMenuOverlay);
    overlays.remove(clearOverlay);
    overlays.remove(gameOverOverlay);
  }

  void onPress() {
    final hitType = hitManager.checkHitType();
    switch (hitType) {
      case HitType.back:
        barBack.onBlinking();
        break;
      case HitType.middle:
        barMiddle.onBlinking();
        break;
      case HitType.center:
        barCenter.onBlinking();
        break;
    }
    enemy.onHitEvent();
    hitText.onHit(hitType: hitType);
    gameManager.hit(hitType: hitType);
  }

  Future<void> _setCharacter() async {
    barBack = BarBack(positionX: size.x / 2, sizeX: size.x);
    await add(barBack);
    barMiddle = BarMiddle(positionX: size.x / 2, sizeX: size.x);
    await add(barMiddle);
    barCenter = BarCenter(positionX: size.x / 2, sizeX: size.x);
    await add(barCenter);
    player = Player(positionX: size.x / 2, sizeX: size.x);
    await add(player);
    enemy = Enemy(positionX: size.x, positionY: size.y);
    await add(enemy);
    hitText = HitText(positionX: size.x, positionY: size.y);
    await add(hitText);
  }
}
