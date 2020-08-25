import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_test/model/item.dart';

import '../database/database_helper.dart';
import '../model/item.dart';

class AddNewItem extends StatefulWidget {
  final Item item;
  final int id;
  final deviceId;
  final List itemId;
  final List name;
  final Function updateItemList;
  AddNewItem({this.item, this.updateItemList, this.name , this.id, this.deviceId, this.itemId});

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  
  DateFormat formattedDate = DateFormat.yMd().add_jm();

  _addItem() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Item item = Item(
          code: codeController.text,
          name: nameController.text,
          date: formattedDate.format(DateTime.now()),
          price: priceController.text,
          category: _category);
      if (widget.item == null) {
        item.id = widget.id == 0 ? 1 : widget.id +1;
        item.dId = widget.deviceId;
        item.lId = item.id.toString() + '0' + widget.deviceId.toString();
        item.synced = 0;
        DatabaseHelper.instance.insertItem(item);
      } else {
        item.id = widget.item.id;
        item.itemId = widget.item.itemId;
        item.dId = widget.item.dId;
        item.lId = widget.item.lId;
        item.category = widget.item.category;
        item.synced = widget.item.synced;
        DatabaseHelper.instance.updateItem(item);
      }
      await widget.updateItemList();
      Navigator.pop(context);
    }
  }

  String _category;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (widget.item != null) {
      nameController.text = widget.item.name;
      codeController.text = widget.item.code;
      priceController.text = widget.item.price;
    }

    return AlertDialog(
      title: Text(widget.item == null ? "Add New Item" : "Update Item"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 18),
                        labelText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (input) =>
                        input.trim().isEmpty ? 'Please Enter Item Name' : null,
                    autofocus: true,
                    controller: nameController,
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 18),
                        labelText: "Code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (input) =>
                        input.trim().isEmpty ? 'Please Enter Item Code' : null,
                    autofocus: false,
                    controller: codeController,
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 18),
                        labelText: "Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (input) =>
                        input.trim().isEmpty ? 'Please Enter Item Price' : null,
                    autofocus: false,
                    controller: priceController,
                  )),
              widget.item ==null ?
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: DropdownButtonFormField(
                      items: widget.name.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        );
                      }).toList(),
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                      ),
                      iconSize: 22,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          labelText: "Category",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (input) => _category == null
                          ? "Please select search category."
                          : null,
                      onChanged: (value) {
                        _category = value;
                      }
                      )
                      ) : Text(widget.item.category)
                      ,
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancle",
              style: TextStyle(color: Colors.blue),
            )),
        FlatButton(
          onPressed: () => _addItem(),
          child: Text(widget.item == null ? 'Add' : 'Update',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
