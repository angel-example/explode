library explode.routes;

import 'dart:async';
import 'dart:io';
import 'package:angel_cors/angel_cors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_proxy/angel_proxy.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/local.dart';
import 'package:http/http.dart' as http;

Future configureServer(Angel app) async {
  // Enable CORS
  app.use(cors());

  // Enable GZIP/DEFLATE compression
  app.injectEncoders({
    'gzip': GZIP.encoder,
    'deflate': ZLIB.encoder,
  });


  // Mount a static server over web/.
  //
  // In production, this automatically mounts over build/web/.
  if (app.isProduction) {
    var vDir = new VirtualDirectory(app, const LocalFileSystem());
    app.use(vDir.handleRequest);
  }

  // Any request that isn't handled by a route, the reverse proxy, or the
  // static server should be handled as a 404.
  app.use((RequestContext req, ResponseContext res) {
    return res.render('error', {'message': 'No file exists at ${req.path}.'});
  });

  // Override the default application error handler with one that renders
  // an error page.
  var oldHandler = app.errorHandler;
  app.errorHandler = (e, req, res) {
    if (req.accepts('text/html', strict: true))
      return res.render('error', {'message': e.message});
    return oldHandler(e, req, res);
  };
}
