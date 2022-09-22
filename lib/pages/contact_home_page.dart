import 'package:contact_app1/pages/contact_details_page.dart';
import 'package:contact_app1/pages/new_contact_page.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactHomePage extends StatelessWidget {
  static const String routeName='/';

  const ContactHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ContactProvider>(context,listen:false).getAll();
    return Scaffold(
      appBar: AppBar(
        title:const Text("Contact List"),
      ),
      body: Consumer<ContactProvider>(
        builder: (context,provider,child)=>
        provider.contactList.isEmpty ? Center(child: Text("No contact found"),):
        ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index){
            final contact = provider.contactList[index];
            return ListTile(
              onTap: ()=>Navigator.pushNamed(
                  context,
                  ContactDetailsPage.routeName,
                  arguments: [contact.id,contact.name],
              ),
              title: Text(contact.name),
              trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(contact.favorite ? Icons.favorite:Icons.favorite_border),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

