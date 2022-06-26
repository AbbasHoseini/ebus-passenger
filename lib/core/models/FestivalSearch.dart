import 'dart:convert';

import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/models/FestivalTown.dart';

class FestivalSearch {
  Festival? festival;
  FestivalTown? festivalTown;
  FestivalSearch({
    this.festival,
    this.festivalTown,
  });

  FestivalSearch copyWith({
    Festival? festival,
    FestivalTown? festivalTown,
  }) {
    return FestivalSearch(
      festival: festival ?? this.festival,
      festivalTown: festivalTown ?? this.festivalTown,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'festival': festival?.toMap(),
      'festivalTown': festivalTown?.toMap(),
    };
  }

  factory FestivalSearch.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return FestivalSearch(
      festival: Festival.fromMap(map['festival']),
      festivalTown: FestivalTown.fromMap(map['festivalTown']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FestivalSearch.fromJson(String source) =>
      FestivalSearch.fromMap(json.decode(source));

  @override
  String toString() =>
      'FestivalSearch(festival: $festival, festivalTown: $festivalTown)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FestivalSearch &&
        o.festival == festival &&
        o.festivalTown == festivalTown;
  }

  @override
  int get hashCode => festival.hashCode ^ festivalTown.hashCode;
}
