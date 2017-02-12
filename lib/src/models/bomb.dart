library angel.models.bomb;

class Bomb {
  String id;

  Bomb({this.id});

  factory Bomb.fromJson(Map data) => new Bomb(id: data['id']);

  Map toJson() {
    return {'id': id};
  }
}
