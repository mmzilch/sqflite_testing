import 'package:flutter/material.dart';
import 'package:sqflite_test/model/item.dart';

class AddNewItem extends StatefulWidget {

   final Item item;
  final Function updateItemList;
  AddNewItem({this.item, this.updateItemList});
  
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}