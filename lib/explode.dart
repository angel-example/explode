library explode;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'src/config/config.dart' as configuration;
import 'src/routes/routes.dart' as routes;
import 'src/services/services.dart' as services;
export 'src/services/services.dart';

/// Configures a server instance.
Future configureServer(Angel app) async {
  await app.configure(configuration.configureServer);
  await app.configure(services.configureServer);
  await app.configure(routes.configureServer);
}