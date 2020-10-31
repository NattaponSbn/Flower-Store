import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pagemain.dart';
import 'Home.dart';

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'บัญชีของฉัน',
        home: Scaffold(
          backgroundColor: Colors.lightGreen[900],
          appBar: AppBar(
            centerTitle: true,
            title: Text('บัญชีของฉัน'),
            backgroundColor: Colors.yellow[800],
            leading: GestureDetector(
              onTap: () {
                backhome();
              },
              child: Icon(
                Icons.home,
                size: 30.0, // add custom icons also
              ),
            ),
          ),
          body: Center(
              child: ListView(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(10),
                child: Image.asset('images/unicorn.png'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อ:',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อผู้ใช้:',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'อีเมล:',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'รหัสผ่าน:',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทร:',
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
                    color: Colors.pink,
                    child: Text(
                      'ออกจากระบบ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      loginout();
                      // print(nameController.text);
                      // print(passwordController.text);
                    },
                  )),
            ],
          )),
        ));
  }

  Future<void> loginout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Index();
    }));
  }

  Future<void> backhome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }
}
