class Explosion {
  String bombId;

  Explosion({this.bombId});

  factory Explosion.fromJson(Map data) => new Explosion(bombId: data['bombId']);

  Map toJson() {
    return {'bombId': bombId};
  }
}
