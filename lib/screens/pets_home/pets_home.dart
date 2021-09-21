import 'package:flutter/material.dart';
import 'package:weight_tracker_mvp/models/pet.dart';
import 'package:weight_tracker_mvp/screens/pets_home/pet_card.dart';
import 'package:weight_tracker_mvp/services/auth.dart';
import 'package:weight_tracker_mvp/shared/loading.dart';
import 'package:weight_tracker_mvp/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;
  

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : StreamProvider<List<Pet>>.value(
          value: DatabaseService().pets,
          initialData: null,
          child: Scaffold(
              backgroundColor: Colors.orange[100],
              appBar: AppBar(
                  title: const Text(
                    'Your Pets',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 25.0,
                    ),
                  ),
                  backgroundColor: Colors.brown,
                  actions: <Widget>[
                    TextButton.icon(
                      icon: const Icon(Icons.person),
                      label: const Text('Sign Out'),
                      onPressed: () async {
                        setState(() => loading = true);
                        await _auth.signOut();
                      },
                    )
                  ]),
              body:  DatabaseService().isEmpty()==true?const PetList():),
        );
  }
}

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key}) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String type = '';

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration:
                            const InputDecoration(hintText: "Name of Pet"),
                      ),
                      const Text('Type of Pet:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Dog"),
                          Radio(
                              value: 'dog',
                              groupValue: 'petType',
                              onChanged: (String? value) {
                                setState(() => type = value.toString());
                              })
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Cat"),
                          Radio(
                              value: 'cat',
                              groupValue: 'petType',
                              onChanged: (String? value) {
                                setState(() => type = value.toString());
                              })
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Rabbit"),
                          Radio(
                              value: 'rabbit',
                              groupValue: 'petType',
                              onChanged: (String? value) {
                                setState(() => type = value.toString());
                              })
                        ],
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add Pet'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      setState() => name = _textEditingController.text;
                      print(name);
                      print(type);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 100.0),
      const Text(
        'You haven\'t added any pets yet ;(',
        style: TextStyle(fontFamily: 'IndieFlower'),
      ),
      const SizedBox(height: 20.0),
      ElevatedButton(
          onPressed: () async {
            await showInformationDialog(context);
          },
          child: const Text(
            'Add Pet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ))
    ]);
  }
}
