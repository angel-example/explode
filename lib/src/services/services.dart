/// Declare services here!
library angel.services;

import 'package:angel_common/angel_common.dart';
import 'package:angel_websocket/server.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'bomb.dart' as Bomb;
import 'explosion.dart' as Explosion;
import 'user.dart' as User;

configureServer(Angel app) async {
  Db db = app.container.make(Db);

  await app.configure(new AngelWebSocket(debug: true));
  await app.configure(Bomb.configureServer());
  await app.configure(Explosion.configureServer());
  await app.configure(User.configureServer(db));
}
