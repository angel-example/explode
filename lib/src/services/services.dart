library explode.services;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';

import 'bomb.dart' as bomb;
import 'explosion.dart' as explosion;

Future configureServer(Angel app) async {
  var ws = new AngelWebSocket(app, sendErrors: !app.isProduction);

  // Configure all services to be broadcasted via WebSocket
  await app.configure(ws.configureServer);

  // Use /ws as the endpoint for WebSockets.
  app.all('/ws', ws.handleRequest);

  await app.configure(bomb.configureServer());
  await app.configure(explosion.configureServer());
}
