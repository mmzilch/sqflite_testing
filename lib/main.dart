import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:sqflite_test/category_screen.dart';
=======
import 'package:sqflite_test/animation_view.dart';
import 'package:sqflite_test/model/category.dart';
import 'package:sqflite_test/search_dialog.dart';

import 'add_new_category.dart';
import 'model/database_helper.dart';
>>>>>>> e54220a1dd5eb2973a8eeb7dffff539097ab120f

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      body: Column(
        children: [
          FlatButton(
              color: Colors.teal,
=======
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
                              child: AnimationView()
                              // Text("There is no category.",
                              //     style: TextStyle(
                              //         color: Colors.teal,
                              //         fontSize: 25,
                              //         fontWeight: FontWeight.bold))
                                      )
                          : DataTable(
                              columns: [
                                  DataColumn(
                                      label: Text('ID',
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
                                          e.id.toString(),
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
                                                  .deleteCategory(e.id);
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
>>>>>>> e54220a1dd5eb2973a8eeb7dffff539097ab120f
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
              child: Text("Category")),
          FlatButton(color: Colors.teal, onPressed: () {}, child: Text("Item"))
        ],
      ),
    );
  }
}
