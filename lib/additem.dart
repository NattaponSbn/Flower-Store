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

import 'dart:io';
import 'show_notification.dart';
import 'package:flutter/material.dart';
import 'logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'Home.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
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

class _AddItemPageState extends State<AddItemPage> {
  File _image;
  String fileName;
  String mainurl;
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  final pdname = TextEditingController();
  final pddes = TextEditingController();
  final store = TextEditingController();
  final phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      fileName = basename(_image.path);
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      firebase_storage.Reference firebaseStorageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(_image);

      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      mainurl = (await firebaseStorageRef.getDownloadURL()).toString();

      addItem(
          context,
          {
            "image": mainurl,
            "nameitem": pdname.text,
            "description": pddes.text,
            "store": store.text,
            "phone": phone.text,
          },
          pdname.text);
      // print('URL Is $mainurl');
      // return mainurl;

      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
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

    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มสินค้า"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                width: 150,
                height: 200.0,
                child: (_image != null)
                    ? Image.file(
                        _image,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        "",
                        fit: BoxFit.fill,
                      ),
              ),
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 320),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.camera,
                  size: 30.0,
                ),
                onPressed: () {
                  getImage();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "ชื่อสินค้า"),
                    controller: pdname,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "ชื่อร้าน"),
                    controller: store,
                  ),
                  // Padding(padding: const EdgeInsets.all(10)),
                  TextField(
                    decoration: InputDecoration(labelText: "รายละเอียดสินค้า"),
                    controller: pddes,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),

                  TextField(
                    decoration: InputDecoration(labelText: "เบอร์โทรติดต่อ"),
                    controller: phone,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  RaisedButton(
                    child: Text("เพิ่มสินค้า"),
                    onPressed: () {
                      if (pdname.text == "" ||
                          pddes.text == "" ||
                          store.text == "" ||
                          phone.text == "") {
                        showMessageBox(
                            context, "เกิดข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบ",
                            actions: [dismissButton(context)]);
                        logger.e("pdname or pddes can't be null");
                      } else {
                        uploadPic(context);
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
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      logger.i("setData success");
    }).catchError((e) {
      logger.e(e);
    });
  }
}
