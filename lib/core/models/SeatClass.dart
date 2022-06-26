import 'dart:convert';

class SeatClass {
  int? classId;
  String? classTitle;
  int? seatPrice;
  SeatClass({
    this.classId,
    this.classTitle,
    this.seatPrice,
  });

  SeatClass copyWith({
    int? classId,
    String? classTitle,
    int? seatPrice,
  }) {
    return SeatClass(
      classId: classId ?? this.classId,
      classTitle: classTitle ?? this.classTitle,
      seatPrice: seatPrice ?? this.seatPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'classTitle': classTitle,
      'seatPrice': seatPrice,
    };
  }

  factory SeatClass.fromMap(map) {
    return SeatClass(
      classId: map['classId'],
      classTitle: map['classTitle'],
      seatPrice: map['seatPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SeatClass.fromJson(source) => SeatClass.fromMap(source);

  @override
  String toString() =>
      'SeatClass(classId: $classId, classTitle: $classTitle, seatPrice: $seatPrice)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeatClass &&
        other.classId == classId &&
        other.classTitle == classTitle &&
        other.seatPrice == seatPrice;
  }

  @override
  int get hashCode =>
      classId.hashCode ^ classTitle.hashCode ^ seatPrice.hashCode;
}
