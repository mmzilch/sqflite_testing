class Item {
  int id;
  int itemId;
  int dId;
  String lId;
  String date;
  String name;
  String code;
  String category;
  String price;
  int synced;

  Item(
      {this.category,
      this.dId,
      this.lId,
      this.itemId,
      this.code,
      this.date,
      this.id,
      this.name,
      this.price,
      this.synced});
  Item.withID(
      {this.category,
      this.itemId,
      this.lId,
      this.dId,
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
    map['dId'] = dId;
    map['lId'] = lId;
    map['itemId'] = itemId;
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
      dId: map['dId'],
      lId: map['lId'],
      itemId: map['itemId'],
      name: map['name'],
      date: map['date'],
      code: map['code'],
      category: map['category'],
      price: map['price'],
      synced: map['synced'],
    );
  }
}
