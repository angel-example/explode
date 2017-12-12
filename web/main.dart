import 'dart:html';
import 'package:explode/models.dart';
import 'package:angel_client/angel_client.dart';
import 'package:angel_websocket/browser.dart';

// `WebSockets` extends the main `Angel` class from `angel_client` ;)
final WebSockets app = new WebSockets('ws://127.0.0.1:3000/ws');
final UListElement $explosions = querySelector('#explosions');
final ButtonElement $btn = querySelector('button');

main() {
  BrowserWebSocketsService bombService = app.service('bombs'),
      explosionService = app.service('explosions');

  app.onError.listen((e) {
    window.alert('Whoops: $e');

    // If `debug` is true in our server-side WebSocket plug-in,
    // it will send us stack traces, which makes it easier to debug.
    window.console.error(e);
    e.errors.map(window.console.error);
  });

  // You MUST connect your WebSocket to the server!
  app.connect().then((_) {
    $btn.onClick.listen((_) async {
      try {
        await bombService.create({});
      } catch (e) {
        window.alert('Bomb creation error: $e');
      }
    });

    // We can use a `ServiceList` to easily manage a real-time collection remotely.
    var explosions = new ServiceList(
      explosionService.unwrap(),

      // The `compare` function is, as its name implies, used to compare two objects.
      // This way, we can automatically update/remove objects based on the server's response.
      compare: (a, b) => a['bomb_id'] == b['bomb_id'],
    );

    // All we have to do is register a single listener for when the collection
    // is modified.
    explosions.onChange.listen((explosions) {
      $explosions.children
        ..clear()
        ..addAll(explosions.map((data) {
          var explosion = new Explosion.fromJson(data);
          return new LIElement()..text = 'Bomb #${explosion.bombId} exploded!';
        }));
    });

    window.alert('Ready to go!');
  });
}
