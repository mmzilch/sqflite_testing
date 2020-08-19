class Item {
  int id;
  String date;
  String name;
  String code;
  String category;
  String price;
  int synced;

  Item(
      {this.category,
      this.code,
      this.date,
      this.id,
      this.name,
      this.price,
      this.synced});
  Item.withID(
      {this.category,
      this.code,
      this.date,
      this.id,
      this.name,
      this.price,
      this.synced});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['date'] = date;
    map['code'] = code;
    map['category'] = category;
    map['price'] = price;
    map['synced'] = synced;
    return map;
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item.withID(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      code: map['code'],
      category: map['category'],
      price: map['price'],
      synced: map['synced'],
    );
  }
}
