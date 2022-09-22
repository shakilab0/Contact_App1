import 'dart:io';
import 'package:contact_app1/models/contact_model.dart';
import 'package:contact_app1/providers/cantact_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:contact_app1/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NewContactPage extends StatefulWidget {
  static const String routeName='/new_contact';
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {

   final _nameController=TextEditingController();
   final _mobileController=TextEditingController();
   final _emailController=TextEditingController();
   final _addressController=TextEditingController();
   String? dob;
   String? imagePath;
   ImageSource source=ImageSource.camera;
   final formKey=GlobalKey<FormState>();

   @override
  void dispose() {
   _nameController.dispose();
   _mobileController.dispose();
   _emailController.dispose();
   _addressController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
        actions: [
          IconButton(
              onPressed: _saveContact,
              icon:const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width:120,
                    height: 120,
                    child: Card(
                      child: imagePath==null ?CircleAvatar(child: const Icon(Icons.person,size: 80,),):
                      CircleAvatar(child:Image.file(File(imagePath!),fit: BoxFit.cover,),),

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: (){
                          source=ImageSource.camera;
                          _getImage();
                        },
                        icon:const Icon(Icons.camera,size: 30,),
                        label: const Text("Capture",style: TextStyle(fontSize: 18),),
                      ),
                      TextButton.icon(
                        onPressed: (){
                          source=ImageSource.gallery;
                          _getImage();
                        },
                        icon:const Icon(Icons.photo_album,size: 30,),
                        label: const Text("Gallery",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              style:const TextStyle(fontSize: 20,color: Colors.white),
              controller: _nameController,
              cursorColor: Colors.black,
              cursorWidth: 2.5,
              decoration: InputDecoration(
                filled: true,
                labelText: "Contact Name*",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:const TextStyle(color: Colors.white,fontSize: 20),
                prefixIcon: const Icon(Icons.person,size: 30,color: Colors.white,),
                fillColor: Colors.green,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Fill up Your Name";
                }else if(value.length>20){
                  return "Youe Name is langer  so type should be 20 characters";
                }
                return null;
              },

            ),

            const SizedBox(height: 10,),
            TextFormField(
              style:const TextStyle(fontSize: 20,color: Colors.white),
              keyboardType: TextInputType.phone,
              controller: _mobileController,
              cursorColor: Colors.black,
              cursorWidth: 2.5,
              decoration: InputDecoration(
                filled: true,
                labelText: "Mobile Number*",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:const TextStyle(color: Colors.white,fontSize: 20),
                prefixIcon: const Icon(Icons.call,size: 30,color: Colors.white,),
                fillColor: Colors.green,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Fill up Your Mobile No";
                }else if(value.length == 11 || value.length ==14){
                  return null;
                }
                return "Invalid Mobile Number";
              },

            ),

            const SizedBox(height: 10,),
            TextFormField(
              style:const TextStyle(fontSize: 20,color: Colors.white),
              controller: _emailController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.emailAddress,
              cursorWidth: 2.5,
              decoration: InputDecoration(
                filled: true,
                labelText: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:const TextStyle(color: Colors.white,fontSize: 20),
                prefixIcon: const Icon(Icons.email,size: 30,color: Colors.white,),
                fillColor: Colors.green,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value){
                return null;
              },

            ),

            const SizedBox(height: 10,),
            TextFormField(
              style:const TextStyle(fontSize: 20,color: Colors.white),
              controller: _addressController,
              cursorColor: Colors.black,
              cursorWidth: 2.5,
              decoration: InputDecoration(
                filled: true,
                labelText: "Street Address",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:const TextStyle(color: Colors.white,fontSize: 20),
                prefixIcon: const Icon(Icons.location_on,size: 30,color: Colors.white,),
                fillColor: Colors.green,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value){
                return null;
              },

            ),

            const SizedBox(height: 10,),
            Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
             ),
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    TextButton.icon(
                        onPressed: _showCalender,
                        icon:const Icon(Icons.calendar_month,color: Colors.white,),
                        label: const Text("Date of Birth : ",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                     Text(dob == null ? "No Date Chosen" : dob!,style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _saveContact() {
     if(formKey.currentState!.validate()){
       final contact=ContactModel(
           name: _nameController.text,
           mobile: _mobileController.text,
           email: _emailController.text,
           streetAddress: _addressController.text,
           image: imagePath,
           dob: dob,
       );
       Provider
           .of<ContactProvider>(context,listen: false)
           .insert(contact).then((id) {
             contact.id = id;
         Provider
             .of<ContactProvider>(context,listen: false).updateList(contact);

             Navigator.pop(context);
       }).catchError((error){
         print(error.toString());
         showMsg(context, "Failed to Save");

       });
     }
  }

  void _showCalender() async{
     final datetime = await showDatePicker(
         context: context,
         initialDate: DateTime.now(),
         firstDate: DateTime(1900),
         lastDate: DateTime.now(),
     );
     if(datetime != null){
       setState(() {
         dob = getFormattedDate(datetime, 'dd-MM-yyyy');
       });
     }
  }

  void _getImage() async{
     final xFile=await ImagePicker().pickImage(source: source,);
     if(xFile != null){
       setState(() {
         imagePath=xFile.path;
       });
     }
  }


}
