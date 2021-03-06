import 'package:flutter/material.dart';
import 'package:sqflite_test/ui/category_screen.dart';

import 'ui/item_screen.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                color: Colors.teal,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen()));
                },
                child: Text("Category")),
            FlatButton(
                color: Colors.teal,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ItemScreen()));
                },
                child: Text("Item"))
          ],
        ),
      ),
    );
  }
}
