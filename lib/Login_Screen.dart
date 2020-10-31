import 'package:projectflutter/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'show_notification.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'อีเมล',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'รหัสผ่าน',
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
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        if (passwordController.text == "" ||
                            nameController.text == "") {
                          showMessageBox(context, "เกิดข้อผิดพลาด",
                              "กรุณากรอกอีเมลเเละรหัสผ่าน",
                              actions: [dismissButton(context)]);
                        } else {
                          loginAu();
                        }
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      'ยังไม่มีบัญชีใช่ไหม?',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      textColor: Colors.yellow[800],
                      child: Text(
                        'สมัครสมาชิก',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegiterPage();
                        }));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  Future<void> loginAu() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String _username = nameController.text.trim();
    String _password = passwordController.text.trim();
    await firebaseAuth
        .signInWithEmailAndPassword(email: _username, password: _password)
        .then((response) {
      showMessageBox(context, "ถูกต้อง", "ยินดีต้อนรับเข้าสู่ระบบ",
          actions: [dismissButton(context)]);
      //print('Authen Success');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      showMessageBox(
          context, "เกิดข้อผิดผลาด", "อีเมลหรือรหัสผ่านคุณไม่ถูกต้อง",
          actions: [dismissButton(context)]);
      // print('ไม่ผ่าน');
    });
  }
}
