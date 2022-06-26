import 'dart:convert';

// GetSearch getSearchFromJson(String str) => GetSearch.fromJson(json.decode(str));

// String getSearchToJson(GetSearch data) => json.encode(data.toJson());

// class GetSearch {
//   GetSearch({
//     this.status,
//     this.data,
//   });

//   String  status;
//   List<Datum>  data;

//   factory GetSearch.fromJson(Map<String, dynamic> json) => GetSearch(
//         status: json["status"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data  .map((x) => x.toJson())),
//       };
// }

class Datum {
  Datum({
    required this.title,
    required this.id,
    required this.townships,
  });

  String  title;
  int  id;
  List<Township> townships;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        id: json["id"],
        townships: List<Township>.from(
            json["Townships"].map((x) => Township.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "Townships": List<dynamic>.from(townships.map((x) => x.toJson())),
      };
}

class Township {
  Township({
    required this.id,
    required this.code,
    required this.title,
    required this.spanData,
    required this.createdAt,
    required this.isCapital,
    required this.isPopular,
    required this.updatedAt,
    required this.provinceId,
    required this.englishTitle,
    required this.persianTitle,
  });

  int  id;
  int  code;
  String  title;
  dynamic  spanData;
  DateTime  createdAt;
  dynamic isCapital;
  int  isPopular;
  DateTime  updatedAt;
  int  provinceId;
  String  englishTitle;
  String  persianTitle;

  factory Township.fromJson(Map<String, dynamic> json) => Township(
        id: json["id"],
        code: json["code"] ?? 0,
        title: json["title"],
        spanData: json["spanData"],
        createdAt: DateTime.parse(json["createdAt"]),
        isCapital: json["isCapital"],
        // isPopular: json["isPopular"] == null   null : json["isPopular"],
        isPopular: json["isPopular"] ?? 0,
        updatedAt: DateTime.parse(json["updatedAt"]),
        provinceId: json["provinceId"],
        englishTitle: json["englishTitle"] ?? 'known',
        persianTitle: json["persianTitle"] ?? 'known',
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
