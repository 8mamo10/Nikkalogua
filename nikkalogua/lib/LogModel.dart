import 'dart:convert';

Log logFromJson(String str) {
  final jsonData = json.decode(str);
  return Log.fromMap(jsonData);
}

String logToJson(Log data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Log {
  int id;
  int nikkaId;
  String date;

  Log({
    this.id,
    this.nikkaId,
    this.date,
  });

  factory Log.fromMap(Map<String, dynamic> json) => new Log(
        id: json["id"],
        nikkaId: json["nikka_id"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nikka_id": nikkaId,
        "date": date,
      };
}
