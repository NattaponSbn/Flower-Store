import 'package:projectflutter/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegiterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegiterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController cpassword = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[800],
        ),
        backgroundColor: Colors.lightGreen[900],
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: cpassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'ยืนยันรหัสผ่าน',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
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
                        'ยืนยัน',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        signUp();
                      },
                    )),
                // Container(
                //     child: Row(
                //   children: <Widget>[
                //     FlatButton(
                //       textColor: Colors.blue,
                //       child: Text(
                //         'เข้าสู่ระบบ',
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       onPressed: () {
                //         cancel();
                //       },
                //     )
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.center,
                // )),
              ],
            )));
  }

  cancel() {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => LoginPage());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  signUp() {
    String _username = username.text.trim();
    String _password = password.text.trim();
    // String confirmPassword = confirmController.text.trim();
    String confirmPassword = cpassword.text.trim();
    if (_password == confirmPassword && _password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: _username, password: _password)
          .then((user) {
        print("Sign up user successful.");
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => LoginPage());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      }).catchError((error) {
        print(error.message);
      });
    } else {
      _showMyDialog();
      print("Password and Confirm-password is not match.");
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('รหัสผ่านไม่ตรงกัน'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                cpassword.text = "";
                password.text = "";
              },
            ),
          ],
        );
      },
    );
  }
}
