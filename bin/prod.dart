#!/usr/bin/env dart
import 'package:angel_framework/angel_framework.dart';
import 'package:explode/explode.dart' as explode;
import 'package:explode/src/pretty_logging.dart';
import 'package:logging/logging.dart';

main() async {
  var app = new Angel();
  await app.configure(explode.configureServer);
  app.logger = new Logger('angel');
  var sub = app.logger.onRecord.listen(prettyLog);
  app.shutdownHooks.add((_) => sub.cancel());
  var server = await app.startServer('127.0.0.1', 3000);
  print('Listening at http://${server.address.address}:${server.port}');
}
