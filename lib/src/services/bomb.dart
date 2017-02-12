import 'dart:async';
import 'package:angel/src/models/bomb.dart';
import 'package:angel/src/models/explosion.dart';
import 'package:angel_framework/angel_framework.dart';

AngelConfigurer configureServer() {
  return (Angel app) async {
    app.use('/bombs', new BombService());

    var service = app.service('bombs') as HookedService;

    service.afterCreated.listen((HookedServiceEvent e) {
      // Bombs should explode 10 seconds after creation.
      var explosionService = e.service.app.service('explosions');
      var bomb = e.result as Map;

      new Future.delayed(new Duration(seconds: 10)).then((_) {
        print('KABOOM!');
        explosionService.create(new Explosion(bombId: bomb['id']));
      });
    });
  };
}

class BombService extends Service {
  final List<Bomb> bombs = [];

  @override
  create(data, [params]) async {
    // We're actually going to ignore the input data
    // in every case, and just spawn a new bomb.
    var bomb = new Bomb(id: bombs.length.toString());
    bombs.add(bomb);
    return bomb.toJson();
  }
}
