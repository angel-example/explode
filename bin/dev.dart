#!/usr/bin/env dart
import 'dart:async';
import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:explode/explode.dart' as explode;
import 'package:explode/src/pretty_logging.dart';
import 'package:logging/logging.dart';

main() async {
  var hot = new HotReloader(() async {
    var app = new Angel();
    await app.configure(explode.configureServer);
    app.logger = new Logger('angel');
    var sub = app.logger.onRecord.listen(prettyLog);
    app.shutdownHooks.add((_) => sub.cancel());
    return app;
  }, [
    new Directory('config'),
    new Directory('lib'),
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  print('Listening at http://${server.address.address}:${server.port}');
}
