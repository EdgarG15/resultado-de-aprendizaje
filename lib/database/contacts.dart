import 'package:flutter/widgets.dart';

class Contact with ChangeNotifier {
  int? id;
  String? name;
  String? lastname;
  String? phoneNumber;

  Contact({this.id, this.name, this.lastname, this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      "phoneNumber": phoneNumber
    };
  }
}
