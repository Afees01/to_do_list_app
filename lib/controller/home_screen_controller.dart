import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreenController {
  static final Taskscollection =
      FirebaseFirestore.instance.collection("Tasks");
  static addData(
      {required String tittle, required bool completed}) {
    Taskscollection.add({"tittle":tittle,"completed":completed});
  }
  
  static Future<void> deleteDAta(String id) async {
    await Taskscollection.doc(id).delete();
  }
}
