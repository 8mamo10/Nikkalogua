import 'dart:convert';

Nikka nikkaFromJson(String str) {
  final jsonData = json.decode(str);
  return Nikka.fromMap(jsonData);
}

String nikkaToJson(Nikka data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Nikka {
  int id;
  String name;
  int color;

  Nikka({
    this.id,
    this.name,
    this.color,
  });

  factory Nikka.fromMap(Map<String, dynamic> json) => new Nikka(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "color": color,
      };
}
