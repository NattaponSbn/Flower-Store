import 'package:flutter/material.dart';
import 'Account.dart';
import 'Home.dart';

class Order extends StatefulWidget {
  @override
  OrderState createState() => OrderState();
}

class OrderState extends State<Order> {
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
      ),
    );
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
