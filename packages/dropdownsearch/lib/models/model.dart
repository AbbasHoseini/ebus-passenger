class Datum {
  Datum({
    this.title,
    this.id,
    this.ts,
  });

  String? title;
  int? id;
  List<dynamic>? ts;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        id: json["id"],
        ts: List<dynamic>.from(
            json["Townships"].map((x) => TS.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "Townships": List<dynamic>.from(ts!.map((x) => x.toJson())),
      };
}

class TS {
  TS({
    this.id,
    this.code,
    this.title,
    this.spanData,
    this.createdAt,
    this.isCapital,
    this.isPopular,
    this.updatedAt,
    this.provinceId,
    this.englishTitle,
    this.persianTitle,
  });

  int? id;
  int? code;
  String? title;
  dynamic? spanData;
  DateTime? createdAt;
  dynamic? isCapital;
  int? isPopular;
  DateTime? updatedAt;
  int? provinceId;
  String? englishTitle, persianTitle;


  factory TS.fromJson(Map<String, dynamic> json) => TS(
        id: json["id"],
        code: json["code"],
        title: json["title"],
        spanData: json["spanData"],
        createdAt: DateTime.parse(json["createdAt"]),
        isCapital: json["isCapital"],
        // isPopular: json["isPopular"] == null   null : json["isPopular"],
        isPopular: json["isPopular"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        provinceId: json["provinceId"],
        englishTitle: json["englishTitle"],
        persianTitle: json["persianTitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "title": title,
        "spanData": spanData,
        // "createdAt": createdAt.toIso8601String(),
        "isCapital": isCapital,
        // "isPopular": isPopular == null   null : isPopular,
        "isPopular": isPopular,
        // "updatedAt": updatedAt.toIso8601String(),
        "provinceId": provinceId,
        "englishTitle": englishTitle,
        "persianTitle": persianTitle,
      };
}
