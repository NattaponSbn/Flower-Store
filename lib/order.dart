import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectflutter/pagemain.dart';
import 'Account.dart';
import 'Home.dart';
import 'detail.dart';

class Order extends StatefulWidget {
  final String pdname;
  final String pddescription;
  final String pirice;
  final String pdid;
  Order(
      {Key key,
      @required this.pdname,
      @required this.pddescription,
      @required this.pirice,
      @required this.pdid})
      : super(key: key);

  @override
  OrderState createState() => OrderState();
}

class OrderState extends State<Order> {
  String pddescription = "Please wait...";

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("catalog")
        .doc(widget.pdid)
        .get()
        .then((value) {
      setState(() {
        // pddescription = value['pddescription'];
        // pirice = value['pirice'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ออเดอร์ของฉัน',
      home: Scaffold(
        backgroundColor: Colors.lightGreen[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text('ออเดอร์ของฉัน'),
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
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    account();
                  },
                  child: Icon(Icons.account_box, size: 30.0),
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {loginout()},
          child: Icon(Icons.logout),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }

  Future<void> loginout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Index();
    }));
  }

  Future<void> account() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Account();
    }));
  }

  Future<void> backhome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }
}
