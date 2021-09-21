import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_mvp/models/pet.dart';
import 'package:weight_tracker_mvp/screens/pets_home/pet_card.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets');

  Future<void> addPet(String name, String type, int age) {
    return petsCollection
        .add({'name': name, 'type': type, 'age': age})
        .then((value) => print("Pet Added"))
        .catchError((error) => print("Failed to add pet: $error"));
  }

  List<Pet> _petListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Pet(doc.get('name'), doc.get(['type']), doc.get(['age']));
    }).toList();
  }

  Future<void> deletePet(String uid) {
    return petsCollection
        .doc(uid)
        .delete()
        .then((value) => print("Pet Deleted"))
        .catchError((error) => print("Failed to delete pet: $error"));
  }

  Stream<List<Pet>> get brews {
    return petsCollection.snapshots().map(_petListFromSnapshot);
  }

  Future<bool> isEmpty() async {
    final snapshot = await FirebaseFirestore.instance.collection('pets').get();
    if (snapshot.docs.isEmpty) {
      //Doesn't exist
      return true;
    } else {
      return false;
    }
  }

  Stream<QuerySnapshot> get pets {
    return petsCollection.snapshots();
  }
}
