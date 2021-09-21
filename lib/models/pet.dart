import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String name;
  final String type;
  final String age;

  final CollectionReference weightsCollection =
      FirebaseFirestore.instance.collection('weights');

  Pet(this.name, this.type, this.age);
}
