// ignore: file_names

import 'package:flutter/material.dart';

import '../requestsESP32/request.dart';

class WebServices extends StatefulWidget {
  const WebServices({Key? key}) : super(key: key);

  @override
  State<WebServices> createState() => _WebServicesState();
}

class _WebServicesState extends State<WebServices> {
  GetRequest getReq = GetRequest();
  PostRequest postReq = PostRequest();
  UpdateRequest updateReq = UpdateRequest();
  DeleteRequest deleteReq = DeleteRequest();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    icon: Icon(
                      Icons.get_app,
                      color: Colors.green.shade700,
                    ),
                    onPressed: () async {
                      String req = await getReq.getData();
                      final snackBar = req == "Error: conexión fallida"
                          ? SnackBar(
                              backgroundColor: Colors.red.shade900,
                              content: Text('Petición terminada: { $req }'),
                              action: SnackBarAction(
                                label: 'Aceptar',
                                onPressed: () {},
                              ))
                          : SnackBar(
                              backgroundColor: Colors.green.shade900,
                              content: Text('Petición completada: { $req }'),
                              action: SnackBarAction(
                                label: 'Aceptar',
                                onPressed: () {},
                              ),
                            );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    label: Text("GET DATA",
                        style: TextStyle(
                            fontSize: 20, color: Colors.green.shade700))),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      String req = await postReq.postData("String x");
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green.shade900,
                        content: Text('Petición completada: { $req }'),
                        action: SnackBarAction(
                          label: 'Aceptar',
                          onPressed: () {},
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    label: const Text("POST DATA",
                        style: TextStyle(fontSize: 20))),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    icon: const Icon(
                      Icons.update,
                      color: Colors.amber,
                    ),
                    onPressed: () async {
                      String req =
                          await updateReq.updateData("Nueva String z", 2);
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green.shade900,
                        content: Text('Petición completada: { $req }'),
                        action: SnackBarAction(
                          label: 'Aceptar',
                          onPressed: () {},
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    label: const Text("UPDATE DATA",
                        style: TextStyle(fontSize: 20, color: Colors.amber))),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      String req = await deleteReq.deleteData(0);
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green.shade900,
                        content: Text('Petición completada: { $req }'),
                        action: SnackBarAction(
                          label: 'Aceptar',
                          onPressed: () {},
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    label: const Text("DELETE DATA",
                        style: TextStyle(fontSize: 20, color: Colors.red))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("SALIR"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
