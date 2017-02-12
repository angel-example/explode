library angel.models.bomb;

class Bomb {
  String id;
  bool exploded;

  Bomb({this.id, this.exploded: false});

  factory Bomb.fromJson(Map data) =>
      new Bomb(id: data['id'], exploded: data['exploded'] == true);

  Map toJson() {
    return {'id': id, 'exploded': exploded == true};
  }
}
