import 'package:contact_app1/models/contact_model.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ContactDetailsPage extends StatelessWidget {
  static const String routeName='/contact_details';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argList= ModalRoute.of(context)!.settings.arguments as List;
    final id=argList[0];
    final name=argList[1];


    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Consumer <ContactProvider>(
        builder:(context, provider,child)=>
            FutureBuilder<ContactModel>(
              future: provider.getById(id),
                builder: (context, snapshot){
                if(snapshot.hasData){
                  final contact=snapshot.data!;
                  return ListView(
                    children: [
                      contact.image==null?
                          Icon(Icons.person,size: 50,):
                      Image.file(File(contact.image!), width: double.infinity, height: 250, fit: BoxFit.cover,),
                      ListTile(
                          title: Text(contact.mobile),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.call),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.sms),
                              ),
                            ],
                          )
                      ),
                      ListTile(
                          title: Text(contact.email!.isEmpty ? 'Email not set yet' : contact.email!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(contact.email!.isEmpty ? Icons.edit : Icons.email),
                              ),
                            ],
                          )
                      ),
                      ListTile(
                          title: Text(contact.streetAddress!.isEmpty ? 'Address not set yet' : contact.streetAddress!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(contact.streetAddress!.isEmpty ? Icons.edit : Icons.location_city),
                              ),
                            ],
                          )
                      ),

                          
                    ],
                  );
                }
                  if(snapshot.hasError){
                    return Center(child: Text("Failed to fetch data"),);
                  }
                  return Center(child: CircularProgressIndicator(),);


                },
            ),
      ),
    );
  }
}
