import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categoryList;
  List<Category> category;

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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddNewCategory(
                        updateCategoryList: _updateCategoryList);
                  },
                );
              }),
        ),
      ),
    );
  }
}