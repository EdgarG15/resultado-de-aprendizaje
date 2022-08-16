// ignore: file_names

import 'package:flutter/material.dart';

import '../database/addContact.dart';
import '../database/contacts.dart';
import '../database/database.dart';
import '../run.dart';

List<Contact> contacts = [];

class SqliteDart extends StatefulWidget {
  const SqliteDart({Key? key}) : super(key: key);

  @override
  State<SqliteDart> createState() => _SqliteDartState();
}

class _SqliteDartState extends State<SqliteDart> {
  @override
  void initState() {
    super.initState();
    _readContacts();
  }

  void _readContacts() async {
    List<Contact> temp = await SqliteDB.contacts();

    setState(() {
      contacts = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
                context: context, builder: (context) => AddContact());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Run()))),
        ),

        body: Container(
          child: contacts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset("assets/images/listEmpty.png"),
                )
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => ListTile(
                    onLongPress: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) => Material(
                                  child: ListView(
                                padding: const EdgeInsets.all(50),
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo nombre",
                                        hintText: contacts[index].name),
                                  ),
                                  TextField(
                                    controller: lastnameController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo apellido",
                                        hintText: contacts[index].lastname),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo teléfono",
                                        hintText: contacts[index].phoneNumber),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        nameText = nameController.text;
                                        lastnameText = lastnameController.text;
                                        phoneNumberText =
                                            phoneNumberController.text;
                                        if (nameText != "" &&
                                            lastnameText != "" &&
                                            phoneNumberText != "") {
                                          Contact temp = Contact(
                                              id: contacts[index].id,
                                              name: nameText,
                                              lastname: lastnameText,
                                              phoneNumber: phoneNumberText);
                                          SqliteDB.update(temp);
                                        }

                                        Navigator.pop(context);
                                        nameController.clear();
                                        lastnameController.clear();
                                        phoneNumberController.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SqliteDart()));
                                      },
                                      child: const Text("GUARDAR CAMBIOS"))
                                ],
                              )));
                    },
                    trailing: IconButton(
                        onPressed: () {
                          Contact temp = Contact(
                              id: contacts[index].id,
                              name: nameText,
                              lastname: lastnameText,
                              phoneNumber: phoneNumberText);
                          SqliteDB.delete(temp);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SqliteDart()));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    leading:
                        const Icon(Icons.account_circle_outlined, size: 30),
                    title: Text(
                      '${contacts[index].name} ${contacts[index].lastname}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      contacts[index].phoneNumber!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
        ),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => const Run()));
        //     },
        //     child: const Text("Atras"))
      ),
    );
  }
}
