import 'package:cloud_firestore/cloud_firestore.dart';
import 'show_notification.dart';
import 'package:flutter/material.dart';

import 'logger_service.dart';

Future<void> addItem(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("catalog")
      .doc(documentName)
      .set(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added item($documentName) to Firestore",
        actions: [dismissButton(context)]);
    logger.i("setData success");
  }).catchError((e) {
    logger.e(e);
  });
}
