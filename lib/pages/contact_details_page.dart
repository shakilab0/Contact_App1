import 'package:contact_app1/models/contact_model.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:contact_app1/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName='/contact_details';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
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
                          const Icon(Icons.person,size: 50,):
                      Image.file(File(contact.image!), width: double.infinity, height: 250, fit: BoxFit.cover,),
                      ListTile(
                          title: Text(contact.mobile),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _callContact(contact.mobile);
                                },
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
                                onPressed: () {
                                  showUpdateDialog(
                                      context: context,
                                      title: "Email",
                                      onSaved: (value)async{
                                        await provider.updateById(id,tblContactColEmail, value);
                                        setState(() {

                                        });
                                      },
                                  );

                                },
                                icon:const Icon(Icons.edit),
                              ),
                              if(contact.email!.isNotEmpty)IconButton(
                                onPressed: () {},
                                icon:const Icon(Icons.email),
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
                                onPressed: () {
                                  showUpdateDialog(
                                    context: context,
                                    title: "Email",
                                    onSaved: (value)async{
                                      await provider.updateById(id,tblContactColAddress, value);
                                      setState(() {

                                      });
                                    },
                                  );
                                },
                                icon:const Icon(Icons.edit ),
                              ),
                              if(contact.email!.isNotEmpty)IconButton(
                                onPressed: () {},
                                icon:const Icon(Icons.location_city),
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

  void _callContact(String mobile)async {
    final url='tel:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perform this operation');
    }
  }
}
