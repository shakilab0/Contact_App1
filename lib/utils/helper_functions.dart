
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String  getFormattedDate(DateTime dt, String pattern){
 return DateFormat(pattern).format(dt);
}

void showMsg(BuildContext context,String msg){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void showUpdateDialog({required BuildContext context, required String title, required Function(String) onSaved}){
  final _controller=TextEditingController();
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text("Update $title"),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Enter new $title",
          filled: true,
        ),
      ),
    ),
    actions: [
      TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("CANCEL"),
      ),
      TextButton(
        onPressed: (){
          if(_controller.text.isEmpty)return;
          final value=_controller.text;
          onSaved(value);
          Navigator.pop(context);
        },
        child: const Text("UPDATE"),
      ),
    ],
  ));
}



