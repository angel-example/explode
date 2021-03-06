import 'dart:async';
import 'package:explode/src/models/bomb.dart';
import 'package:explode/src/models/explosion.dart';
import 'package:angel_framework/angel_framework.dart';

AngelConfigurer configureServer() {
  return (Angel app) async {
   HookedService service = app.use('/bombs', new BombService());

    service.afterCreated.listen((HookedServiceEvent e) {
      // Bombs should explode 10 seconds after creation.
      var explosionService = e.getService('explosions');
      var bomb = e.result as Bomb;

      new Future.delayed(new Duration(seconds: 10)).then((_) {
        print('KABOOM!');
        explosionService.create(new Explosion(bombId: bomb.id));
      });
    });
  };
}

class BombService extends Service {
  final List<Bomb> bombs = [];

  @override
  index([params]) async => bombs;

  @override
  create(data, [params]) async {
    // We're actually going to ignore the input data
    // in every case, and just spawn a new bomb.
    var bomb = new Bomb(id: bombs.length.toString());
    bombs.add(bomb);
    return bomb;
  }
}
