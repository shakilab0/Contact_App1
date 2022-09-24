import 'package:contact_app1/models/contact_model.dart';
import 'package:contact_app1/pages/contact_details_page.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';


class ContactItem extends StatefulWidget {
  final ContactModel contact;
  final ContactProvider provider;
  const ContactItem({Key? key,required this.contact,required this.provider}) : super(key: key);

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                title: Text("Delete"),
                content: Text('Are you sure to delete this contact'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('YES'),
                  )
                ]));
      },
      onDismissed: (direction){
        widget.provider.deleteById(widget.contact.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),
        child: ListTile(
          //tileColor: HexColor("#A7F6AB"),
          onTap: () => Navigator.pushNamed(
            context,
            ContactDetailsPage.routeName,
            arguments: [widget.contact.id, widget.contact.name],
          ),
          leading:CircleAvatar(
            child: Icon(Icons.person),
          ),

          title: Text(widget.contact.name),
          trailing: IconButton(
            onPressed: () {
              final value=widget.contact.favorite?0:1;
              widget.provider.updateById(widget.contact.id, tblContactColFavorite, value);
              widget.contact.favorite=!widget.contact.favorite;
              setState(() {

              });
            },
            icon: Icon(widget.contact.favorite ? Icons.favorite : Icons.favorite_border),
          ),


        ),
      ),
    );
  }
}
