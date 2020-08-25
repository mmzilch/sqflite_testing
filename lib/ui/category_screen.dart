import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/model/category.dart';
import 'package:sqflite_test/ui/add_new_category.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_test/ui/search_dialog.dart';

import '../database/database_helper.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categoryList;
  List<Category> category;
  int deviceId = 3;

  @override
  void initState() {
    super.initState();
    _updateCategoryList();
  }

  _updateCategoryList() async {
    _categoryList = await DatabaseHelper.instance.getCategoryList();
    setState(() {
      category = _categoryList;
    });
  }

  _updateSearchList(String usersearch, String cloumn) async {
    _categoryList =
        await DatabaseHelper.instance.getSearchList(usersearch, cloumn);
    setState(() {
      category = _categoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(""),
          backgroundColor: Colors.teal,
          title: Text('Category'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SearchDialog(updateSearchList: _updateSearchList);
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _updateCategoryList();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: category == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.teal)),
                  )
                : Container(
                    height: category.length == 0
                        ? MediaQuery.of(context).size.height
                        : null,
                    width: category.length == 0
                        ? MediaQuery.of(context).size.width
                        : null,
                    child: category.length == 0
                        ? Center(
                            child: Text("There is no category.",
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
                                    label: Text('DID',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                                DataColumn(
                                    label: Text('LID',
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
                                    label: Text('Name',
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
                            rows: category
                                .map((e) => DataRow(cells: [
                                      DataCell(Text(
                                        e.categoryId.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      )),
                                      DataCell(Text(
                                        e.dId.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      )),
                                      DataCell(Text(
                                        e.lId.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      )),
                                      DataCell(Text(e.code,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                      DataCell(Text(e.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17))),
                                      DataCell(Text(e.date,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))),
                                      DataCell(
                                        Checkbox(
                                          onChanged: (value) {
                                            e.synced = value ? 1 : 0;
                                            print(e.synced);
                                            DatabaseHelper.instance
                                                .updateCategory(e);
                                            _updateCategoryList();
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
                                              databaseName: "category_table",
                                            );
                                            _updateCategoryList();
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
                                                return AddNewCategory(
                                                    category: e,
                                                    updateCategoryList:
                                                        _updateCategoryList);
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
              List<Category> categoryIdList =
                  await DatabaseHelper.instance.getCategoryIdList(deviceId);
              List<int> idList = categoryIdList.map((e) => e.id).toList();
               print(idList.isEmpty ? 0 : idList.reduce((curr, next) => curr > next? curr: next));

               List<Category> cateIdList = await DatabaseHelper.instance.getCateIdList();
              
               print("cateIDLIST>>>"+  cateIdList.map((e) => e.categoryId).toList().toString());
              showDialog(
                context: context,
                builder: (context) {
                  return AddNewCategory(
                    deviceId: deviceId,
                      updateCategoryList: _updateCategoryList,
                      id: idList.isEmpty
                          ? 0
                          : idList.reduce(
                              (curr, next) => curr > next ? curr : next),
                              cateId: cateIdList.map((e) => e.categoryId).toList(),);
                },
              );
            }),
      ),
    );
  }
}
