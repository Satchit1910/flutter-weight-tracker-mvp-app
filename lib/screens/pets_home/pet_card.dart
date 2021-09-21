import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_mvp/models/pet.dart';

class PetList extends StatefulWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  Widget build(BuildContext context) {

    final pets = Provider.of<List<Pet>>(context);
    //print(brews.documents);
    pets.forEach((pet) {
      print(pet.name);
      print(pet.type);
      print(pet.age);
    })

    return Container(
      
    );
  }
}