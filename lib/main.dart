import 'package:contact_app1/pages/contact_details_page.dart';
import 'package:contact_app1/pages/contact_home_page.dart';
import 'package:contact_app1/pages/new_contact_page.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context)=>ContactProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),

      //home: NewContactPage(),

      initialRoute: ContactHomePage.routeName,

      routes: {
        ContactHomePage.routeName:(context)=>ContactHomePage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),

      },
    );
  }
}
