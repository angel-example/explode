// GENERATED CODE - DO NOT MODIFY BY HAND

part of explode.src.models.explosion;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Explosion extends _Explosion {
  @override
  String bombId;

  Explosion({this.bombId});

  factory Explosion.fromJson(Map data) {
    return new Explosion(bombId: data['bomb_id']);
  }

  Map<String, dynamic> toJson() => {'bomb_id': bombId};

  static Explosion parse(Map map) => new Explosion.fromJson(map);

  Explosion clone() {
    return new Explosion.fromJson(toJson());
  }
}
