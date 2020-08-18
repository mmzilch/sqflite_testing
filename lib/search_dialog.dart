import 'package:flutter/material.dart';
import 'package:sqflite_test/model/category.dart';
import 'package:sqflite_test/model/database_helper.dart';

class SearchDialog extends StatefulWidget {
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final List<String> _searchItems = ['Id', 'Name', 'Code', 'Date Time'];
  String _searchName;
  String _searchBy;
  String userSearchInput = '';

  @override
  void initState() {
    super.initState();
    _searchCategoryList('D');
    print(_searchCategoryList('D'));
  }

  _searchCategoryList(String userInput) async{

   search(String userInput){
      setState(() {
        userInput = titleController.text;
        if(userInput.isEmpty){
          return;
        }else{
          userSearchInput = userInput;
        }
      });
   }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Search Category"),
      content: Form(
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
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (input) => input.trim().isEmpty
                      ? 'Please Enter Your Search Item'
                      : null,
                  onSaved: (input) => _searchName = input,
                  autofocus: true,
                controller: titleController,
                  initialValue: _searchName,
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: DropdownButtonFormField(
                    items: _searchItems.map((String searchItems) {
                      return DropdownMenuItem(
                        value: searchItems,
                        child: Text(searchItems,
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
                        labelText: "Search By...",
                        labelStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (input) => _searchBy == null
                        ? "Please select search category."
                        : null,
                    onChanged: (value) {
                      _searchBy = value;
                    })),
          ],
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
          onPressed: () {
            // _searchCategoryList(titleController.text);
          },
          child: Text('Search'),
        )
      ],
    );
  }
}
