import 'package:flutter/material.dart';
import 'package:sqflite_test/ui/add_new_item.dart';
import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/model/item.dart';

import 'model/category.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Item> _itemList;
  List<Item> item;

  @override
  void initState() {
    super.initState();
    _updateItemList();
  }

  _updateItemList() async {
    _itemList = await DatabaseHelper.instance.getItemList();
    setState(() {
      item = _itemList;
    });
  }

  // _updateSearchList(String usersearch, String cloumn) async {
  //   _itemList =
  //       await DatabaseHelper.instance.getItemSearchList(usersearch, cloumn);
  //   setState(() {
  //     item = _itemList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(""),
          backgroundColor: Colors.teal,
          title: Text('Item'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     //return SearchDialog(updateSearchList: _updateSearchList);
                //   },
                // );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _updateItemList();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: item == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.teal)),
                  )
                : Container(
                    height: item.length == 0
                        ? MediaQuery.of(context).size.height
                        : null,
                    width: item.length == 0
                        ? MediaQuery.of(context).size.width
                        : null,
                    child: item.length == 0
                        ? Center(
                            child: Text("There is no item.",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)))
                        : DataTable(
                            columns: [
                                DataColumn(
                                    label: Text('ID',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Code',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('UpdateTime',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Category',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Price',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Synced',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Delete',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('Update',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                              ],
                            rows: item
                                .map((e) => DataRow(cells: [
                                      DataCell(Text(
                                        e.id.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      )),
                                      DataCell(Text(e.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17))),
                                      DataCell(Text(e.code,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                      DataCell(Text(e.date,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))),
                                      DataCell(Text(e.category,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17))),
                                      DataCell(Text(e.price.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17))),
                                      DataCell(
                                        Checkbox(
                                          onChanged: (value) {
                                            e.synced = value ? 1 : 0;
                                            DatabaseHelper.instance
                                                .updateItem(e);
                                            _updateItemList();
                                          },
                                          activeColor: Colors.green,
                                          value: e.synced == 1 ? true : false,
                                        ),
                                      ),
                                      DataCell(IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            DatabaseHelper.instance
                                                .deleteCategory(
                                              id: e.id,
                                              databaseName: "item_table",
                                            );

                                            _updateItemList();
                                          })),
                                      DataCell(IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: (context),
                                              builder: (context) {
                                                return AddNewItem(
                                                    item: e,
                                                    updateItemList:
                                                        _updateItemList);
                                              },
                                            );
                                          })),
                                    ]))
                                .toList()),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Icon(Icons.add),
            onPressed: () async {
              List<Category> nameList =
                  await DatabaseHelper.instance.getNameList();
              print(nameList.map((e) => e.name).toList());
              showDialog(
                context: context,
                builder: (context) {
                  return AddNewItem(
                    updateItemList: _updateItemList,
                    name: nameList.map((e) => e.name).toList(),
                  );
                },
              );
            }),
      ),
    );
  }
}