class Category {
  int id;
  int categoryId;
  int dId;
  String lId;
  String date;
  String name;
  String code;
  int synced;

  Category({this.id, this.categoryId, this.date, this.synced, this.name, this.code,this.dId,this.lId});
  Category.withID({this.id, this.categoryId, this.date, this.name, this.synced, this.code,this.lId,this.dId});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['categoryId'] = categoryId;
    map['dId'] = dId;
    map['lId'] = lId;
    map['name'] = name;
    map['date'] = date;
    map['code'] = code;
    map['synced'] = synced;
    return map;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category.withID(
      id: map['id'],
      categoryId: map['categoryId'],
      dId: map['dId'],
      lId: map['lId'],
      name: map['name'],
      date: map['date'],
      code: map['code'],
      synced: map['synced'],
    );
  }
}
