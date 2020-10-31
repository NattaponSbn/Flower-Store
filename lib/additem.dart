// import 'package:flutter/material.dart';

// class Order extends StatefulWidget {
//   @override
//   OrderState createState() => OrderState();
// }

// class OrderState extends State<Order> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'เพิ่มสินค้า',
//       home: Scaffold(
//         backgroundColor: Colors.lightGreen[900],
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('เพิ่มสินค้า'),
//           backgroundColor: Colors.yellow[800],
//         ),
//       ),
//     );
//   }
// }

import 'show_notification.dart';
import 'package:flutter/material.dart';
import 'logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final pdname = TextEditingController();
  final pddes = TextEditingController();
  final pice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "ชื่อสินค้า"),
                    controller: pdname,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  TextField(
                    decoration: InputDecoration(labelText: "รายละเอียดสินค้า"),
                    controller: pddes,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "ราคาของสินค้า"),
                    controller: pice,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  RaisedButton(
                    child: Text("Add items"),
                    onPressed: () {
                      if (pdname.text == "" ||
                          pddes.text == "" ||
                          pice.text == "") {
                        showMessageBox(
                            context, "เกิดข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบ",
                            actions: [dismissButton(context)]);
                        logger.e("pdname or pddes can't be null");
                      } else {
                        addItem(
                            context,
                            {
                              "nameitem": pdname.text,
                              "description": pddes.text,
                              "pirice": pice.text,
                            },
                            pdname.text);
                        pdname.text = "";
                        pddes.text = "";
                        pice.text = "";
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> addItem(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("catalog")
        .doc()
        .set(data)
        .then((returnData) {
      showMessageBox(context, "เรียบร้อย",
          "คุณได้เพิ่ม($documentName)ลงไปในสโตร์เรียบร้อย",
          actions: [dismissButton(context)]);
      logger.i("setData success");
    }).catchError((e) {
      logger.e(e);
    });
  }
}
