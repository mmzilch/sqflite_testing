import 'package:flutter/material.dart';

class SearchItemDialog extends StatefulWidget {
  final Function updateSearchItemList;
  SearchItemDialog({this.updateSearchItemList});
  @override
  _SearchItemDialogState createState() => _SearchItemDialogState();
}

class _SearchItemDialogState extends State<SearchItemDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final List<String> _searchItems = ['Id', 'Name', 'Code', 'Date','Price'];
  String _searchName;
  String _searchBy;
  String userSearchInput = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Search Item"),
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
                        ? "Please select search item."
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
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Navigator.pop(context);
            }
            widget.updateSearchItemList(titleController.text, _searchBy);
          },
          child: Text(
            'Search',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
