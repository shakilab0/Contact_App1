import 'package:contact_app1/datab/db_helper.dart';
import 'package:contact_app1/models/contact_model.dart';
import 'package:flutter/material.dart';


class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  Future<int> insert(ContactModel contactModel) =>
      DbHelper.insert(contactModel);

  void getAll() async {
    contactList = await DbHelper.getAll();
    notifyListeners();
  }

  Future<ContactModel> getById(int? id) =>
      DbHelper.getById(id);

  void updateList(ContactModel contactModel) {
    contactList.add(contactModel);
    notifyListeners();
  }


}