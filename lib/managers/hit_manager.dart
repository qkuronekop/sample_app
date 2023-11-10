import 'package:flame/components.dart';
import 'package:sample_app/sprites/player.dart';
import 'package:sample_app/timing_game.dart';

class HitManager extends Component with HasGameRef<TimingGame> {
  HitType checkHitType() {
    final player = gameRef.player;
    if (_checkCenter(player: player)) {
      return HitType.center;
    } else if (_checkMiddle(player: player)) {
      return HitType.middle;
    } else {
      return HitType.back;
    }
  }

  bool _checkMiddle({required Player player}) {
    final barMiddle = gameRef.barMiddle;
    final barHalf = barMiddle.width / 2;
    final barLeft = barMiddle.position.x - barHalf;
    final barRight = barMiddle.position.x + barHalf;
    final playerPosition = player.position.x;
    return playerPosition >= barLeft && playerPosition <= barRight;
  }

  bool _checkCenter({required Player player}) {
    final barCenter = gameRef.barCenter;
    final barHalf = barCenter.width / 2;
    final barLeft = barCenter.position.x - barHalf;
    final barRight = barCenter.position.x + barHalf;
    final playerPosition = player.position.x;
    return playerPosition >= barLeft && playerPosition <= barRight;
  }
}

enum HitType {
  back(5),
  middle(10),
  center(15);

  const HitType(this.hitPoint);

  final int hitPoint;
}
