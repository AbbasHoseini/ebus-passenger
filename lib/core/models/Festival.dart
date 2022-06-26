import 'dart:convert';

class Festival {
  int? id, festivalTownshipId, discountValue;
  bool? status;
  String? festivalTitle, festivalDescription, startDate, endDate, title;
  List<dynamic> images;
  Festival({
    this.id,
    this.status,
    this.festivalTownshipId,
    this.festivalTitle,
    this.festivalDescription,
    this.startDate,
    this.endDate,
    this.title,
    this.discountValue,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'festival_township_id': festivalTownshipId,
      'festival_title': festivalTitle,
      'festival_description': festivalDescription,
      'start_date': startDate,
      'end_date': endDate,
      'title': title,
      'discount_value': discountValue,
      'images': images,
    };
  }

  factory Festival.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Festival(
      id: map['id'],
      status: map['status'],
      festivalTownshipId: map['festival_township_id'],
      festivalTitle: map['festival_title'],
      festivalDescription: map['festival_description'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      title: map['title'],
      discountValue: map['discount_value'],
      images: map['images'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Festival.fromJson(source) => Festival.fromMap(source);

  @override
  String toString() {
    return 'Festival(id: $id, status: $status, festival_township_id: $festivalTownshipId, festival_title: $festivalTitle, festival_description: $festivalDescription, start_date: $startDate, end_date: $endDate, title: $title, discount_value: $discountValue)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Festival &&
        o.id == id &&
        o.status == status &&
        o.festivalTownshipId == festivalTownshipId &&
        o.festivalTitle == festivalTitle &&
        o.festivalDescription == festivalDescription &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.title == title &&
        o.discountValue == discountValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        festivalTownshipId.hashCode ^
        festivalTitle.hashCode ^
        festivalDescription.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        title.hashCode ^
        discountValue.hashCode;
  }
}
