class Category {
  int id;
  DateTime date;
  String name;
  String code;
  int synced;

  Category({this.id, this.date, this.synced, this.name, this.code});
  Category.withID({this.id, this.date, this.name, this.synced, this.code});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['date'] = date.toIso8601String();
    map['code'] = code;
    map['synced'] = synced;
    return map;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category.withID(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      code: map['code'],
      synced: map['synced'],
    );
  }
}