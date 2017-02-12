import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/hooks.dart' as hooks;
import '../models/explosion.dart';

// Hurrah for pure functions :D
AngelConfigurer configureServer() {
  return (Angel app) async {
    // The `AnonymousService` class is a shortcut
    // you can use to create a service with minimal
    // functionality, without creating a whole new
    // class.
    app.use('/explosions', new AnonymousService(create: (Explosion data, [params]) {
      // This service will simply echo whatever we give to it.
      //
      // We expect `data` to be a Map with a `bombId`.
      // Validation will be covered in a later tutorial.
      return {'bombId': data.bombId};
    }));

    // Use service hooks to add additional functionality to
    // services.
    //
    // This pattern is preferred, as hooks can be applied to any
    // service, regardless of what data store (if any) is being
    // used.
    var service = app.service('explosions') as HookedService;
    service.beforeAll(hooks.disable()); // Disable for all clients
  };
}
