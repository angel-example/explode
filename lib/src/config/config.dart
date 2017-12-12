library explode.config;

import 'dart:async';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_mustache/angel_mustache.dart';
import 'package:file/local.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'plugins/plugins.dart' as plugins;

/// This is a perfect place to include configuration and load plug-ins.
Future configureServer(Angel app) async {
  var fs = const LocalFileSystem();
  await app.configure(configuration(fs));
  var db = new Db(app.configuration['mongo_db']);
  await db.open();

  await app.configure(mustache(fs.directory('views')));
  await plugins.configureServer(app);
}
