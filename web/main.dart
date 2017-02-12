import 'dart:html';
import 'package:angel/src/models/models.dart';
import 'package:angel_websocket/browser.dart';

// `WebSockets` extends the main `Angel` class from `angel_client` ;)
final WebSockets app = new WebSockets('ws://${window.location.host}/ws');
final UListElement $explosions = querySelector('#explosions');
final ButtonElement $btn = querySelector('button');

main() async {
  // You MUST connect your WebSocket to the server!
  await app.connect();

  WebSocketsService bombService = app.service('bombs'),
      explosionService = app.service('explosions');

  app.onError.listen((e) {
    print('Whoops: $e');
    print(e.errors);
  });

  explosionService.onCreated.listen((e) {
    var explosion = new Explosion.fromJson(e.data);
    $explosions.children
        .add(new LIElement()..text = 'Bomb #${explosion.bombId} exploded!');
  });

  $btn.onClick.listen((_) => bombService.create({}).catchError((e) {
        window.alert('Bomb creation error: $e');
      }));
}
