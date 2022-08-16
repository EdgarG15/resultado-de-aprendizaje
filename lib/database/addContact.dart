import 'package:flutter/material.dart';
import '../pages/sqlite.dart';
import 'contacts.dart';
import 'database.dart';

final nameController = TextEditingController();
final lastnameController = TextEditingController();
final phoneNumberController = TextEditingController();

String? nameText;
String? lastnameText;
String? phoneNumberText;

class AddContact extends StatefulWidget {
  AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(
      padding: const EdgeInsets.all(50),
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Nombre"),
        ),
        TextField(
          controller: lastnameController,
          decoration: const InputDecoration(labelText: "Apellido"),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: phoneNumberController,
          decoration: const InputDecoration(labelText: "Teléfono"),
        ),
        ElevatedButton(
            onPressed: () {
              nameText = nameController.text;
              lastnameText = lastnameController.text;
              phoneNumberText = phoneNumberController.text;
              if (nameText != "" &&
                  lastnameText != "" &&
                  phoneNumberText != "") {
                setState(() {
                  Contact temp = Contact(
                      name: nameText!,
                      lastname: lastnameText!,
                      phoneNumber: phoneNumberText!);
                  SqliteDB.insert(temp);
                });
              }
              Navigator.pop(context);
              nameController.clear();
              lastnameController.clear();
              phoneNumberController.clear();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SqliteDart()));
            },
            child: const Text("Guardar")),
      ],
    ));
  }
}
