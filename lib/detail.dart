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

//   Future<void> account() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Account();
//     }));
//   }

//   Future<void> backhome() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Home();
//     }));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String pdname;
  final String pddescription;
  final String pirice;
  final String pdid;
  Detail(
      {Key key,
      @required this.pdname,
      @required this.pddescription,
      @required this.pirice,
      @required this.pdid})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
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
      appBar: AppBar(
        title: Text(widget.pdname),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.pdname,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
            ),
            Text(
              widget.pddescription,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
            ),
            Text(
              widget.pirice,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
