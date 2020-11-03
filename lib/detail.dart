// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'order.dart';
// import 'Account.dart';
// import 'Home.dart';

// class Detail extends StatefulWidget {
//   final String pdname;
//   final String pddescription;
//   Detail({Key key, @required this.pdname, @required this.pddescription})
//       : super(key: key);
//   @override
//   DetailState createState() => DetailState();
// }

// class DetailState extends State<Detail> {
//   String pddescription = "Please wait...";

//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("catalog")
//         .doc(widget.pdname)
//         .get()
//         .then((value) {
//       setState(() {
//         pddescription = value.data["description"];
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'รายละเอียดสินค้า',
//       home: Scaffold(
//         backgroundColor: Colors.lightGreen[900],
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('รายละเอียดสินค้า'),
//           backgroundColor: Colors.yellow[800],
//           leading: GestureDetector(
//             onTap: () {
//               backhome();
//             },
//             child: Icon(
//               Icons.home,
//               size: 30.0, // add custom icons also
//             ),
//           ),
//           actions: <Widget>[
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     account();
//                   },
//                   child: Icon(Icons.account_box, size: 30.0),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import 'order.dart';
import 'Account.dart';
import 'Home.dart';

class Detail extends StatefulWidget {
  final String pdname;
  final String pddescription;
  final String store;
  final String pdid;
  final String phone;
  final String image;
  Detail({
    Key key,
    @required this.pdname,
    @required this.pddescription,
    @required this.store,
    @required this.pdid,
    @required this.phone,
    @required this.image,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class Getimage extends ChangeNotifier {
  Getimage();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(Image)
        .getDownloadURL();
  }
}

Future<Widget> getimage(BuildContext context, String imgeName) async {
  Image image;
  await Getimage.loadImage(context, imgeName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}

class _DetailPageState extends State<Detail> {
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
    return Scaffold(
        backgroundColor: Colors.lightGreen[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text('รายละเอียดสินค้า'),
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
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    account();
                  },
                  child: Icon(Icons.account_box, size: 30.0),
                )),
          ],
        ),
        body: Center(
          child: Card(
            child: Container(
              color: Colors.white,
              // padding: new EdgeInsets.only(top: 16.0),
              width: 330.0,
              height: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      width: 200.0,
                      height: 210.0,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                      // child: FutureBuilder(
                      //   future: getimage(
                      //       context, "image_picker2531859951023978732.jpg"),
                      // ),
                    ),
                  ),
                  Text(
                    widget.pdname,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                  ),
                  Text(
                    widget.store,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                  ),
                  Text(
                    pddescription,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  Text(
                    'ช่องทางการติดต่อ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                  ),
                  Text(
                    widget.phone,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          'สั่งซื้อ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Order(
                                        pdid: widget.pdid,
                                        pdname: widget.pdname,
                                        pddescription: widget.pddescription,
                                        pirice: widget.store,
                                      )));
                        },
                      )),
                ],
              ),
            ),
          ),
        ));
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
