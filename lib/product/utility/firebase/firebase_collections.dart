import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  version;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
