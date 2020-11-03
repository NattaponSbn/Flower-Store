import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => new _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(30, (index) {
              return new Card(
                elevation: 10.0,
                child: new Container(
                  child: new Text("$index"),
                ),
              );
            })));
  }
}
