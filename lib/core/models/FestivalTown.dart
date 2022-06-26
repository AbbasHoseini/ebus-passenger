import 'dart:convert';

class FestivalTown {
  int? id;
  int? count;
  String? name;
  FestivalTown({
    this.id,
    this.count,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count_of_travels': count,
      'title': name,
    };
  }

  factory FestivalTown.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return FestivalTown(
      id: map['id'],
      count: map['count_of_travels'],
      name: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FestivalTown.fromJson(source) => FestivalTown.fromMap(source);

  @override
  String toString() => 'FestivalTown(id: $id, count: $count, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FestivalTown &&
        o.id == id &&
        o.count == count &&
        o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ count.hashCode ^ name.hashCode;
}
