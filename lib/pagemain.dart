import 'package:flutter/material.dart';
import 'Login_Screen.dart';
import 'Register.dart';
import 'additem.dart';

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.lightGreen[900],
          body: Center(
              child: ListView(children: <Widget>[
            Container(
              width: 500,
              height: 500,
              child: Image.asset('images/unicorn.png'),
            ),
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(120, 10, 120, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                )),
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(120, 10, 120, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  textColor: Colors.white,
                  color: Colors.green[700],
                  child: Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RegiterPage();
                    }));
                  },
                )),
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(120, 10, 120, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  textColor: Colors.white,
                  color: Colors.green[700],
                  child: Text(
                    'ต้องการขายของ',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddItemPage();
                    }));
                  },
                )),
          ]))),
    );
  }
}
