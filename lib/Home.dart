import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'pagemain.dart';
import 'Account.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'หน้าหลัก',
      home: Scaffold(
        backgroundColor: Colors.lightGreen[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text('หน้าหลัก'),
          backgroundColor: Colors.yellow[800],
          leading: GestureDetector(
            onTap: () {},
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("catalog").snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot catalog = snapshot.data.docs[index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Container(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                pdid: catalog.id,
                                                pdname: catalog['nameitem'],
                                                pddescription:
                                                    catalog['description'],
                                                pirice: catalog['pirice'],
                                              )));
                                },
                                child: Column(children: <Widget>[
                                  ListTile(
                                    // leading: Image.network(catalog['img']),
                                    title: Text(catalog['nameitem']),
                                    subtitle: Text(catalog['description']),
                                  ),
                                ])))));
              },
            );
          },
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
}
