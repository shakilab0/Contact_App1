import 'package:contact_app1/pages/new_contact_page.dart';
import 'package:flutter/material.dart';

class ContactHomePage extends StatelessWidget {
  static const String routeName='/';

  const ContactHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Contact List"),
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

