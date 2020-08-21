import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_test/model/category.dart';
import 'database/database_helper.dart';

class AddNewCategory extends StatefulWidget {
  final Category category;
  final Function updateCategoryList;
  AddNewCategory({this.category, this.updateCategoryList});
  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  _addCategory() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Category category = Category(
        code: codeController.text,
        name: nameController.text,
        date: formattedDate.format(DateTime.now()),
      );
      if (widget.category == null) {
        category.synced = 0;
        DatabaseHelper.instance.insertCategory(category);
      } else {
        category.id = widget.category.id;
        category.synced = widget.category.synced;
        DatabaseHelper.instance.updateCategory(category);
      }
      await widget.updateCategoryList();
      Navigator.pop(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  DateFormat formattedDate = DateFormat.yMd().add_jm();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.category != null) {
      nameController.text = widget.category.name;
      codeController.text = widget.category.code;
    }
    return AlertDialog(
      title: Text(
          widget.category == null ? "Add New Category" : "Update Category"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (input) =>
                    input.trim().isEmpty ? "Please enter name." : null,
                autofocus: true,
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (input) =>
                    input.trim().isEmpty ? "Please enter code." : null,
                keyboardType: TextInputType.number,
                controller: codeController,
                decoration: InputDecoration(hintText: "Code"),
              ),
            ),
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
            onPressed: () => _addCategory(),
            child: Text(widget.category == null ? "Add" : "Update",
                style: TextStyle(color: Colors.blue)))
      ],
    );
  }
}
